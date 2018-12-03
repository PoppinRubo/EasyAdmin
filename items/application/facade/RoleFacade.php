<?php
namespace app\facade;

use app\model\SysRoleButtonModel;
use app\model\SysRoleModuleModel;

class RoleFacade
{
    /**
     *角色关联模块
     */
    public static function relationModule(array $a)
    {
        $baseResult = new \stdClass();
        try {
            if ($a["roleId"] < 0 || !is_Array(json_decode($a["ids"]))) {
                return toJsonData(0, null, "参数错误");
            }
            $id = trim(trim($a["ids"], "]"), "[");
            $ids = json_decode($a["ids"]);
            $data = db('sys_role_module')->whereIn('ModuleId', $id)->where(array("RoleId" => $a["roleId"]))->select();
            //存在的记录模块编号
            $in = array();
            foreach ($data as $d) {
                foreach ($ids as $i) {
                    if ($i == $d["ModuleId"]) {
                        $in["Id"][] = $d["Id"];
                        $in["ModuleId"][] = $d["ModuleId"];
                    }
                }
            }
            //操作的数据
            $data = array();
            foreach ($ids as $i) {
                $inId = count($in) < 1 ? false : array_search($i, $in["ModuleId"]);
                if ($inId !== false) {
                    //更新可用状态，数据复活
                    $update = array(
                        'Id' => $in["Id"][$inId],
                        'IsValid' => $a["isRelation"] ? 1 : 0,
                        'IsDel' => $a["isRelation"] ? 0 : 1,
                        "ModifyTime" => date("Y-m-d H:i:s"),
                        "ModifyUser" => $a["operaterId"],
                    );
                    array_push($data, $update);
                } else if ($a["isRelation"]) {
                    //插入数据
                    $insert = array(
                        "ModuleId" => $i,
                        "RoleId" => $a["roleId"],
                        "CreateTime" => date("Y-m-d H:i:s"),
                        "CreateUser" => $a["operaterId"],
                        "ModifyTime" => date("Y-m-d H:i:s"),
                        "ModifyUser" => $a["operaterId"],
                    );
                    array_push($data, $insert);
                }
            }
            $model = new SysRoleModuleModel();
            //批量操作数据库
            $model->saveAll($data);
            $baseResult->result = true;
        } catch (Exception $e) {
            $baseResult->result = false;
            $msg->$e->getMessage();
        }
        return $baseResult;
    }

    /**
     *角色关联模块按钮
     */
    public static function relationButton(array $a)
    {
        $baseResult = new \stdClass();
        try {
            if ($a["roleId"] < 0 || $a["moduleId"] < 0 || !is_Array(json_decode($a["ids"]))) {
                return toJsonData(0, null, "参数错误");
            }
            $id = trim(trim($a["ids"], "]"), "[");
            $ids = json_decode($a["ids"]);
            $data = db('sys_role_button')->whereIn('ButtonId', $id)->where(array("RoleId" => $a["roleId"], "ModuleId" => $a["moduleId"]))->select();
            //存在的记录模块编号
            $in = array();
            foreach ($data as $d) {
                foreach ($ids as $i) {
                    if ($i == $d["ButtonId"]) {
                        $in["Id"][] = $d["Id"];
                        $in["ButtonId"][] = $d["ButtonId"];
                    }
                }
            }
            //操作的数据
            $data = array();
            foreach ($ids as $i) {
                $inId = count($in) < 1 ? false : array_search($i, $in["ButtonId"]);
                if ($inId !== false) {
                    //更新可用状态，数据复活
                    $update = array(
                        'Id' => $in["Id"][$inId],
                        'IsValid' => $a["isRelation"] ? 1 : 0,
                        'IsDel' => $a["isRelation"] ? 0 : 1,
                        "ModifyTime" => date("Y-m-d H:i:s"),
                        "ModifyUser" => $a["operaterId"],
                    );
                    array_push($data, $update);
                } else if ($a["isRelation"]) {
                    //插入数据
                    $insert = array(
                        "ButtonId" => $i,
                        "ModuleId" => $a["moduleId"],
                        "RoleId" => $a["roleId"],
                        "CreateTime" => date("Y-m-d H:i:s"),
                        "CreateUser" => $a["operaterId"],
                        "ModifyTime" => date("Y-m-d H:i:s"),
                        "ModifyUser" => $a["operaterId"],
                    );
                    array_push($data, $insert);
                }
            }
            $model = new SysRoleButtonModel();
            //批量操作数据库
            $model->saveAll($data);
            $baseResult->result = true;
        } catch (Exception $e) {
            $baseResult->result = false;
            $msg->$e->getMessage();
        }
        return $baseResult;
    }

}
