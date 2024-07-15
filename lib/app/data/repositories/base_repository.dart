import 'package:dio/dio.dart';
import 'package:easybill_app/app/core/exceptions.dart';
import 'package:easybill_app/app/data/api/http_client.dart';
import 'package:easybill_app/app/data/models/response_model.dart';

class BaseRepo {
  final DioClient _client = DioClient();

  Future<List<T>?> post<T extends BaseModel>(String path,
      {required body,
      required ResponseResultDecoder<T> decoder,
      ResponseAsListHandler<T>? responseHandler}) async {
    try {
      Response response = await _client.post(
        path,
        data: body,
      );
      if (responseHandler != null) return responseHandler(response);
      return BtResponse<T>.fromJson(response.data, decoder).results;
    } catch (e) {
      throw (EbException(e));
    }
  }
  

  Future<void> postWithOutResponse<T extends BaseModel>(String path,
      {required body, ResponseAsListHandler<T>? responseHandler}) async {
    try {
      await _client.post(
        path,
        data: body,
      );
    } catch (e) {
      throw (EbException(e));
    }
  }

  Future<List<T>?> get<T extends BaseModel>(String path,
      {Map<String, dynamic>? body,
      required ResponseResultDecoder<T> decoder,
      ResponseAsListHandler<T>? responseHandler}) async {
    try {
      Response response = await _client.post(
        path,
        data: body,
      );
      if (responseHandler != null) return responseHandler(response);
      return BtResponse<T>.fromJson(response.data, decoder).results;
    } catch (e) {
      throw (EbException(e));
    }
  }

  Future<List<T>?> realGet<T extends BaseModel>(String path,
      {required ResponseResultDecoder<T> decoder,
      ResponseAsListHandler<T>? responseHandler}) async {
    try {
      Response response = await _client.get(
        path,
      );
      if (responseHandler != null) return responseHandler(response);
      return BtResponse<T>.fromJson(response.data, decoder).results;
    } catch (e) {
      throw (EbException(e));
    }
  }

  Future<List<T>?> patch<T extends BaseModel>(
    String path, {
    required dynamic body,
    required ResponseResultDecoder<T> decoder,
    ResponseAsListHandler<T>? responseHandler,
  }) async {
    try {
      //used to test conditions during debugging. verifying whether body is in required format
      assert(body is Map<String, dynamic> || body is FormData);
      Response response = await _client.patch(
        path,
        data: body,
      );
      if (responseHandler != null) return responseHandler(response);
      return BtResponse<T>.fromJson(response.data, decoder).results;
    } catch (e) {
      throw (EbException(e));
    }
  }

  Future<List<T>?> delete<T extends BaseModel>(
    String path, {
    required Map<String, dynamic> body,
    required ResponseResultDecoder<T> decoder,
    ResponseAsListHandler<T>? responseHandler,
  }) async {
    try {
      Response response = await _client.delete(
        path,
        data: body,
      );
      if (responseHandler != null) return responseHandler(response);
      return BtResponse<T>.fromJson(response.data, decoder).results;
    } catch (e) {
      throw (EbException(e));
    }
  }

  Future<List<T>?> put<T extends BaseModel>(
    String path, {
    required Map<String, dynamic> body,
    required ResponseResultDecoder<T> decoder,
    ResponseAsListHandler<T>? responseHandler,
  }) async {
    try {
      Response response = await _client.put(
        path,
        data: body,
      );
      if (responseHandler != null) return responseHandler(response);
      return BtResponse<T>.fromJson(response.data, decoder).results;
    } catch (e) {
      throw (EbException(e));
    }
  }
}
