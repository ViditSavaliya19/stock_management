import 'package:srock_management/model/designation_model.dart';
import 'package:srock_management/model/user_model.dart';
import 'package:srock_management/screen/user_register/model/permission_model.dart';
import 'package:srock_management/utils/constants.dart';

class PermissionHelper {
  static PermissionHelper helper = PermissionHelper._();

  PermissionHelper._();


  final List<PermissionModel> defaultPermissionList = [
    PermissionModel(
        permissionId: "permission_1",
        permissionName: "Add & display users",
        permission: false),
    PermissionModel(
        permissionId: "permission_2",
        permissionName: "Daily total stock quantity category wise",
        permission: false),
    PermissionModel(
        permissionId: "permission_3",
        permissionName: "Only visible all company stock",
        permission: false),
    PermissionModel(
        permissionId: "permission_4",
        permissionName: "Add & display stock of assign company",
        permission: false),
  ];

  List getPermissionCodeToDesignation(UserModel user, List<DesignationModel> totalDesignation) {
    // userDesignations[0] because in any user profile added only one permission
    if (user.designation!.isNotEmpty && totalDesignation.isNotEmpty) {
      for (var x in totalDesignation) {
        if (x.desiName == user.designation![0]) {
          print("@ Permission 1 =====  ${x.permissionIds}");
          return x.permissionIds!;
        }
      }
      print("@ Permission 2 =====  ");
      return [];
    } else {
      print("@ Permission 3 =====  ");
      return [];
    }
  }

  //not in used
  bool checkPermissionOfAccess({required List permission, menuName})
  {
    if(menuName=="user" && permission.contains(PERMISSION_1,))
    {
        return true;
    }
    else
      {
        return false;
      }
  }

}
