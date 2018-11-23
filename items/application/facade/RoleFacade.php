<?php
namespace app\facade;

use app\model\SysRoleModule;

class RoleFacade
{
    /**
     *关联模块
     */
    public static function relation(array $a)
    {
        $baseResult = new \stdClass();
        try {
            if ($a["roleId"] < 0 || !is_Array(json_decode($a["ids"]))) {
                return toJsonData(0, null, "参数错误");
            }
            $model = new SysRoleModule();
            $id = trim(trim($a["ids"], "]"), "[");
            $ids = json_decode($a["ids"]);
            $data = db('sys_role_module')->whereIn('ModuleId', $id)->where(array("RoleId" => $a["roleId"]))->select();
            //存在的记录模块编号
            $in = array();
            foreach ($data as $d) {
                foreach ($ids as $i) {
                    if ($i == $d["ModuleId"]) {
                        array_push($in, $i);
                    }
                }
            }
            //关联SQL生成
            $sql = "";
            foreach ($ids as $i) {
                if (in_array($i, $in)) {
                    //更新可用状态，数据复活
                    $update = array(
                        'IsValid' => $a["isRelation"] ? 1 : 0,
                        'IsDel' => $a["isRelation"] ? 0 : 1,
                        "ModifyTime" => date("Y-m-d H:i:s"),
                        "ModifyUser" => $a["operaterId"],
                    );
                    $sql .= db('sys_role_module')->fetchSql(true)->where(array("ModuleId" => $i, "RoleId" => $a["roleId"]))->update($update);
                    $sql .= ";";
                } else if ($a["isRelation"]) {
                    $insert = array(
                        "ModuleId" => $a["moduleId"],
                        "RoleId" => $a["roleId"],
                        "CreateTime" => date("Y-m-d H:i:s"),
                        "CreateUser" => $a["operaterId"],
                        "ModifyTime" => date("Y-m-d H:i:s"),
                        "ModifyUser" => $a["operaterId"],
                    );
                    $sql .= db('sys_role_module')->fetchSql(true)->insert($insert);
                    $sql .= ";";
                }
            }
            $baseResult->result = true;
            // 启动事务
            db()->startTrans();
            try {
                db()->execute($sql);
                // 提交事务
                db()->commit();
            } catch (Exception $e) {
                // 回滚事务
                db()->rollback();
                $baseResult->result = false;
                $msg->$e->getMessage();
            }
        } catch (Exception $e) {
            $baseResult->result = false;
            $msg->$e->getMessage();
        }
        return $baseResult;
    }
}
