import 'package:flutter_ui_project/data/api/api_client.dart';
import 'package:get/get.dart';
import '../../utils/app_constants.dart';

class PopularProductRepo extends GetxService {
 final ApiClient apiClient;
 PopularProductRepo({required this.apiClient});
 Future<Response> getPopularProductRepoList() async{
return await apiClient.getData(AppConstants.POP_PRODUCT_URI);
}
}