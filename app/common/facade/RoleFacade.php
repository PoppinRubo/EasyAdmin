<?php
namespace app\common\facade;

use app\common\facade\ResultFacade;
use app\common\model\SysRoleButtonModel;
use app\common\model\SysRoleModuleModel;
use think\facade\Db;

class RoleFacade
{
    /**
     *角色关联模块
     */
    public static function relationModule(array $a)
    {
        $result = new ResultFacade(config('code.error'));
        try {
            if ($a["roleId"] < 0 || !is_Array(json_decode($a["ids"]))) {
                $result->msg = "参数错误";
                return $result;
            }
            $id = trim(trim($a["ids"], "]"), "[");
            $ids = json_decode($a["ids"]);
            $data = Db::name('sys_role_module')->whereIn('module_id', $id)->where(array("role_id" => $a["roleId"]))->select()->toArray();
            //存在的记录模块编号
            $in = array();
            foreach ($data as $d) {
                foreach ($ids as $i) {
                    if ($i == $d["module_id"]) {
                        $in["id"][] = $d["id"];
                        $in["module_id"][] = $d["module_id"];
                    }
                }
            }
            //操作的数据
            $data = array();
            foreach ($ids as $i) {
                $inId = count($in) < 1 ? false : array_search($i, $in["module_id"]);
                if ($inId !== false) {
                    //更新可用状态，数据复活
                    $update = array(
                        'id' => $in["id"][$inId],
                        'is_valid' => $a["isRelation"] ? 1 : 0,
                        'is_del' => $a["isRelation"] ? 0 : 1,
                        "modify_time" => date("Y-m-d H:i:s"),
                        "modify_user" => $a["operaterId"],
                    );
                    array_push($data, $update);
                } else if ($a["isRelation"]) {
                    //插入数据
                    $insert = array(
                        "module_id" => $i,
                        "role_id" => $a["roleId"],
                        "create_time" => date("Y-m-d H:i:s"),
                        "create_user" => $a["operaterId"],
                        "modify_time" => date("Y-m-d H:i:s"),
                        "modify_user" => $a["operaterId"],
                    );
                    array_push($data, $insert);
                }
            }
            $model = new SysRoleModuleModel();
            //批量操作数据库
            $model->saveAll($data);
            $result->code = config('code.success');
        } catch (\Exception $e) {
            $result->msg = $e->getMessage();
        }
        return $result;
    }

    /**
     *角色关联模块按钮
     */
    public static function relationButton(array $a)
    {
        $result = new ResultFacade(config('code.error'));
        try {
            if ($a["roleId"] < 0 || $a["moduleId"] < 0 || !is_Array(json_decode($a["ids"]))) {
                $result->msg = "参数错误";
                return $result;
            }
            $id = trim(trim($a["ids"], "]"), "[");
            $ids = json_decode($a["ids"]);
            $data = Db::name('sys_role_button')->whereIn('button_id', $id)->where(array("role_id" => $a["roleId"], "module_id" => $a["moduleId"]))->select()->toArray();
            //存在的记录模块编号
            $in = array();
            foreach ($data as $d) {
                foreach ($ids as $i) {
                    if ($i == $d["button_id"]) {
                        $in["id"][] = $d["id"];
                        $in["button_id"][] = $d["button_id"];
                    }
                }
            }
            //操作的数据
            $data = array();
            foreach ($ids as $i) {
                $inId = count($in) < 1 ? false : array_search($i, $in["button_id"]);
                if ($inId !== false) {
                    //更新可用状态，数据复活
                    $update = array(
                        'id' => $in["id"][$inId],
                        'is_valid' => $a["isRelation"] ? 1 : 0,
                        'is_del' => $a["isRelation"] ? 0 : 1,
                        "modify_time" => date("Y-m-d H:i:s"),
                        "modify_user" => $a["operaterId"],
                    );
                    array_push($data, $update);
                } else if ($a["isRelation"]) {
                    //插入数据
                    $insert = array(
                        "button_id" => $i,
                        "module_id" => $a["moduleId"],
                        "role_id" => $a["roleId"],
                        "create_time" => date("Y-m-d H:i:s"),
                        "create_user" => $a["operaterId"],
                        "modify_time" => date("Y-m-d H:i:s"),
                        "modify_user" => $a["operaterId"],
                    );
                    array_push($data, $insert);
                }
            }
            $model = new SysRoleButtonModel();
            //批量操作数据库
            $model->saveAll($data);
            $result->code = config('code.success');
        } catch (\Exception $e) {
            $result->msg = $e->getMessage();
        }
        return $result;
    }

}
