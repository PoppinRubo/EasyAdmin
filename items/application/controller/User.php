<?php
namespace app\controller;

use app\facade\UserFacade;
use app\model\SysUser;
use app\model\SysUserRole;
use think\Exception;

class User extends Basic
{
    //用户列表 View
    public function index()
    {
        //获取按钮
        $this->assign('button', $this->getModuleButton());
        return View();
    }

    //添加用户 View || Json
    public function add()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                //首字母还原为大写
                $data = convertInitials(input(), false);
                //密码md5加密
                $data["Password"] = md5($data["Password"]);
                $data["CreateTime"] = date("Y-m-d H:i:s");
                $data["CreateUser"] = $this->user["Id"];
                $data["ModifyTime"] = $data["CreateTime"];
                $data["ModifyUser"] = $data["CreateUser"];
                if (UserFacade::isExist($data["Account"])) {
                    return toJsonData(0, null, "账号已存在");
                }
                $model = new SysUser();
                // 过滤表单数组中的非数据表字段数据
                $model->allowField(true)->save($data);
                return toJsonData(1, null, "操作成功");
            } catch (Exception $e) {
                return toJsonData(0, null, $e->getMessage());
            }
        }
        //输出页面
        $model = getEmptyModel('SysUser');
        $this->assign('model', convertInitials($model));
        return View();
    }

    //编辑用户 View || Json
    public function edit()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                //首字母还原为大写
                $data = convertInitials(input(), false);
                $data["ModifyTime"] = date("Y-m-d H:i:s");
                $data["ModifyUser"] = $this->user["Id"];
                $model = new SysUser();
                // 过滤表单数组中的非数据表字段数据
                $model->allowField(true)->save($data, ['Id' => $data["Id"]]);
                return toJsonData(1, null, "操作成功");
            } catch (Exception $e) {
                return toJsonData(0, null, $e->getMessage());
            }
        }
        //输出页面
        $id = input("id") ?: 0;
        $model = SysUser::get($id)->getData();
        $this->assign('model', convertInitials($model));
        return View();
    }

    //删除用户 Json
    public function remove()
    {
        try {
            $id = input("id") ?: 0;
            $data = array(
                "IsDel" => 1,
                "ModifyTime" => date("Y-m-d H:i:s"),
                "ModifyUser" => $this->user["Id"],
            );
            $model = new SysUser();
            $model->save($data, ['Id' => $id]);
            return toJsonData(1, null, "操作成功");
        } catch (Exception $e) {
            return toJsonData(0, null, $e->getMessage());
        }
    }

    //获取用户列表
    public function getUserList()
    {
        try {
            $limit = input("limit") ?: 10;
            $key = input("key") ?: "";
            $data = db('sys_user')->where(array("IsDel" => 0))->where(is_numeric($key) ? 'Id' : 'UserName', 'like', '%' . $key . '%')->paginate($limit);
            return toEasyTable($data);
        } catch (Exception $e) {
            return toEasyTable([], false, $e->getMessage());
        }
    }

    //密码修改 View || Json
    public function password()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                //首字母还原为大写
                $data = convertInitials(input(), false);
                $data["ModifyTime"] = date("Y-m-d H:i:s");
                $data["ModifyUser"] = $this->user["Id"];
                $user = db('sys_user')->where(array("Id" => $this->user["Id"]))->find();
                if ($user == null) {
                    return toJsonData(0, null, "获取当前登录用户失败");
                }
                if (md5($data["OldPassword"]) != $user["Password"]) {
                    return toJsonData(0, null, "旧密码不正确");
                }
                if ($data["NewPassword"] != $data["Password"]) {
                    return toJsonData(0, null, "新密码与确认密码不一致");
                }
                //密码md5加密
                $data["Password"] = md5($data["Password"]);
                $model = new SysUser();
                // 过滤表单数组中的非数据表字段数据
                $model->allowField(true)->save($data, ['Id' => $this->user["Id"]]);
                return toJsonData(1, null, "操作成功");
            } catch (Exception $e) {
                return toJsonData(0, null, $e->getMessage());
            }
        }
        return View();
    }

    //密码重置 Json
    public function resetPassword()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                $userId = input("userId");
                if (empty($userId) || $userId <= 0) {
                    return toJsonData(0, null, "参数错误");
                }
                $data = array(
                    "Id" => $userId,
                    "Password" => md5("666666"),
                    "ModifyTime" => date("Y-m-d H:i:s"),
                    "ModifyUser" => $this->user["Id"],
                );
                $model = new SysUser();
                // 过滤表单数组中的非数据表字段数据
                $model->allowField(true)->save($data, ['Id' => $userId]);
                return toJsonData(1, null, "密码已重置为 666666");
            } catch (Exception $e) {
                return toJsonData(0, null, $e->getMessage());
            }
        }
        return toJsonData(0, null, "不被接受的请求");
    }

    //用户角色列表 View
    public function role()
    {
        return View();
    }

    //获取用户角色列表
    public function getUserRoleList()
    {
        try {
            $key = input("key") ?: "";
            $userId = input("userId") ?: 0;
            //搜索
            $search = $key == "" ? "" : is_numeric($key) ? "AND t1.Id={$key}" : "AND t1.Name like '%{$key}%'";
            $data = db()->query("
            SELECT t1.Id,t1.Name,{$userId} AS UserId,CASE WHEN t2.Id IS NULL THEN FALSE ELSE TRUE END AS IsRelation
            FROM sys_role AS t1 LEFT JOIN sys_user_role AS t2 ON(t2.UserId={$userId} AND t2.RoleId=t1.Id AND t2.IsDel=0)
            WHERE t1.IsDel=0 {$search} ORDER BY (CASE WHEN t2.Id IS NULL THEN 1 ELSE 0 END) ASC,t1.Sort ASC;");
            return toEasyTable($data);
        } catch (Exception $e) {
            return toEasyTable([], false, $e->getMessage());
        }
    }

    //用户关联角色 Json
    public function relationRole()
    {
        try {
            $userId = input("userId") ?: 0;
            $roleId = input("roleId") ?: 0;
            if ($userId < 0 || $roleId < 0) {
                return toJsonData(0, null, "参数错误");
            }
            $model = new SysUserRole();
            $data = db('sys_user_role')->where(array("UserId" => $userId, "RoleId" => $roleId))->find();
            if ($data == null) {
                //新增关联插入记录
                $model->save(array(
                    "UserId" => $userId,
                    "RoleId" => $roleId,
                    "CreateTime" => date("Y-m-d H:i:s"),
                    "CreateUser" => $this->user["Id"],
                    "ModifyTime" => date("Y-m-d H:i:s"),
                    "ModifyUser" => $this->user["Id"],
                ));
                return toJsonData(1, null, "操作成功");
            }
            //更新可用状态
            $data['IsValid'] = 1;
            $data['IsDel'] = 0;
            $data["ModifyTime"] = date("Y-m-d H:i:s");
            $data["ModifyUser"] = $this->user["Id"];
            $model->save($data, ['Id' => $data['Id']]);
            return toJsonData(1, null, "操作成功");
        } catch (Exception $e) {
            return toJsonData(0, null, $e->getMessage());
        }
    }

    //用户删除关联角色 Json
    public function delRelationRole()
    {
        try {
            $userId = input("userId") ?: 0;
            $roleId = input("roleId") ?: 0;
            if ($userId < 0 || $roleId < 0) {
                return toJsonData(0, null, "参数错误");
            }
            $model = new SysUserRole();
            $data = db('sys_user_role')->where(array("UserId" => $userId, "RoleId" => $roleId))->find();
            if ($data == null) {
                return toJsonData(0, null, "未找到关联数据,无法删除关联");
            }
            //恢复可用状态
            $data['IsValid'] = 0;
            $data['IsDel'] = 1;
            $data["ModifyTime"] = date("Y-m-d H:i:s");
            $data["ModifyUser"] = $this->user["Id"];
            $model->save($data, ['Id' => $data['Id']]);
            return toJsonData(1, null, "操作成功");
        } catch (Exception $e) {
            return toJsonData(0, null, $e->getMessage());
        }
    }
}
