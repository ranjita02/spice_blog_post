import 'dart:convert';
import 'dart:developer';

import 'package:spice_blog_22/blogs/datasource/models.dart';
import 'package:spice_blog_22/common/network_client/network_client.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BlogRepository {
  static BlogRepository? _instance;
  WebSocketChannel? _channel;

  BlogRepository._(); // Private Constructor
  factory BlogRepository() {
    _instance ??= BlogRepository._(); // ??= is called Elvis Operator

    _instance!._channel ??= WebSocketChannel.connect(
        Uri.parse('wss://spiceblogserver-production.up.railway.app/ws'));

    return _instance!;
  }

  Stream<List<Blog>> fetchAllBlogs() async* {
    yield* _instance!._channel!.stream.map((event) {
      try {
        final data = json.decode(event);
        return data.map<Blog>((e) => Blog.fromJson(e)).toList();
      } catch (_) {
        return <Blog>[];
      }
    });
  }

  Future<void> addBlog(Blog blog) async {
    final res = await NetworkClient.post('addBlog', data: blog.toJson());
    log(res.body);
  }

  Future<bool> deleteBlog(int id) async {
    final res = await NetworkClient.delete('deleteBlog?id=$id');
    return res.statusCode == 200;
  }
}