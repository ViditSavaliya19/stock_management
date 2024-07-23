class DesignationModel
{
    String? desiName;
    String? docId;
    List? permissionIds=[];

    DesignationModel({this.desiName, this.permissionIds,this.docId});


    factory DesignationModel.mapToModel(Map m1)
    {
      return DesignationModel(
        desiName: m1['desi_name'],
        permissionIds: m1['permission_Id']
      );
    }
    Map<String,dynamic> modelToMap()
    {
      return {
        'desi_name':desiName,
        'permission_Id':permissionIds
      };
    }


}
