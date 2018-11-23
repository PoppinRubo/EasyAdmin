<?php
namespace app\facade;

use app\model\SysRoleModule;

class RoleFacade
{
    /**
     *关联模块
     */
    public static function relation(bool $isRelation, int $moduleId, int $roleId, int $operaterId)
    {
        $baseResult = new \stdClass();
        try {
            if ($moduleId < 0 || $roleId < 0) {
                return toJsonData(0, null, "参数错误");
            }
            $model = new SysRoleModule();
            $data = db('sys_role_module')->where(array("ModuleId" => $moduleId, "RoleId" => $roleId))->find();
            if ($data == null && $isRelation) {
                //新增关联插入记录
                $model->save(array(
                    "ModuleId" => $moduleId,
                    "RoleId" => $roleId,
                    "CreateTime" => date("Y-m-d H:i:s"),
                    "CreateUser" => $operaterId,
                    "ModifyTime" => date("Y-m-d H:i:s"),
                    "ModifyUser" => $operaterId,
                ));
            } else {
                //更新可用状态
                $data['IsValid'] = $isRelation ? 1 : 0;
                $data['IsDel'] = $isRelation ? 0 : 1;
                $data["ModifyTime"] = date("Y-m-d H:i:s");
                $data["ModifyUser"] = $operaterId;
                $model->save($data, ['Id' => $data['Id']]);
            }
            $baseResult->result = true;
        } catch (Exception $e) {
            $baseResult->result = false;
            $msg->$e->getMessage();
        }
        return $baseResult;
    }
}
