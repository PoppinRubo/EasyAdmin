<?php
namespace app\admin\controller;

use app\common\facade\UserFacade;
use app\common\model\SysUserModel;
use app\common\model\SysUserRoleModel;
use think\facade\Db;
use think\facade\View;

class UserController extends BasicController
{
    //用户列表 View
    public function index()
    {
        //获取按钮
        View::assign(['button' => $this->getModuleButton()]);
        return View::fetch();
    }

    //添加用户 View || Json
    public function add()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                $data = input();
                //密码md5加密
                $data["Password"] = md5($data["Password"]);
                $data["CreateTime"] = date("Y-m-d H:i:s");
                $data["CreateUser"] = $this->user["Id"];
                $data["ModifyTime"] = $data["CreateTime"];
                $data["ModifyUser"] = $data["CreateUser"];
                if (UserFacade::isExist($data["Account"])) {
                    return jsonOut(config('code.error'), "账号已存在");
                }
                $model = new SysUserModel();
                // 过滤表单数组中的非数据表字段数据
                $model->save($data);
                return jsonOut(config('code.success'), "操作成功");
            } catch (\Exception $e) {
                return jsonOut(config('code.error'), $e->getMessage());
            }
        }
        //输出页面
        $model = getEmptyModel('SysUser');
        View::assign(['model' => $model]);
        return View::fetch();
    }

    //编辑用户 View || Json
    public function edit()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                $data = input();
                $data["ModifyTime"] = date("Y-m-d H:i:s");
                $data["ModifyUser"] = $this->user["Id"];
                //更新数据
                $model = SysUserModel::find($data["Id"]);
                $model->save($data);
                return jsonOut(config('code.success'), "操作成功");
            } catch (\Exception $e) {
                return jsonOut(config('code.error'), $e->getMessage());
            }
        }
        //输出页面
        $id = input("id") ?: 0;
        $model = SysUserModel::find($id)->getData();
        View::assign(['model' => $model]);
        return View::fetch();
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
            //更新数据
            $model = SysUserModel::find($id);
            $model->save($data);
            return jsonOut(config('code.success'), "操作成功");
        } catch (\Exception $e) {
            return jsonOut(config('code.error'), $e->getMessage());
        }
    }

    //获取用户列表
    public function getUserList()
    {
        try {
            $limit = input("rows") ?: 10;
            $key = input("key") ?: "";
            $sort = input("sort") ?: "Id";
            $order = input("order") ?: "desc";
            //查询条件
            $where = [['IsDel', '=', 0]];
            if (!empty($key)) {
                //编号查询
                if (is_numeric($key)) {
                    $where[] = ['Id', '=', $key];
                } else {
                    //名称查询
                    $where[] = ['UserName', 'like', '%' . $key . '%'];
                }
            }
            $data = Db::name('sys_user')->where($where)->order($sort, $order)->paginate($limit);
            return toEasyTable($data);
        } catch (\Exception $e) {
            return toEasyTable([], false, $e->getMessage());
        }
    }

    //密码修改 View || Json
    public function password()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                $data = input();
                $data["ModifyTime"] = date("Y-m-d H:i:s");
                $data["ModifyUser"] = $this->user["Id"];
                $model = SysUserModel::find($this->user["Id"]);
                if (empty($model->Id)) {
                    return jsonOut(config('code.error'), "获取当前登录用户失败");
                }
                if (md5($data["OldPassword"]) != $model->Password) {
                    return jsonOut(config('code.error'), "旧密码不正确");
                }
                if ($data["NewPassword"] != $data["Password"]) {
                    return jsonOut(config('code.error'), "新密码与确认密码不一致");
                }
                //密码md5加密
                $data["Password"] = md5($data["Password"]);
                //更新数据
                $model->save($data);
                return jsonOut(config('code.success'), "操作成功");
            } catch (\Exception $e) {
                return jsonOut(config('code.error'), $e->getMessage());
            }
        }
        return View::fetch();
    }

    //密码重置 Json
    public function resetPassword()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                $userId = input("userId");
                if (empty($userId) || $userId <= 0) {
                    return jsonOut(config('code.error'), "参数错误");
                }
                $data = array(
                    "Id" => $userId,
                    "Password" => md5("666666"),
                    "ModifyTime" => date("Y-m-d H:i:s"),
                    "ModifyUser" => $this->user["Id"],
                );
                //更新数据
                $model = SysUserModel::find($userId);
                $model->save($data);
                return jsonOut(config('code.success'), "密码已重置为 666666");
            } catch (\Exception $e) {
                return jsonOut(config('code.error'), $e->getMessage());
            }
        }
        return jsonOut(config('code.error'), "不被接受的请求");
    }

    //用户角色列表 View
    public function role()
    {
        return View::fetch();
    }

    //获取用户角色列表
    public function getUserRoleList()
    {
        try {
            $key = input("key") ?: "";
            $userId = input("userId") ?: 0;
            //搜索
            $search = $key == "" ? "" : is_numeric($key) ? "AND t1.Id={$key}" : "AND t1.Name like '%{$key}%'";
            $data = Db::query("
            SELECT t1.Id,t1.Name,{$userId} AS UserId,CASE WHEN t2.Id IS NULL THEN FALSE ELSE TRUE END AS IsRelation
            FROM sys_role AS t1 LEFT JOIN sys_user_role AS t2 ON(t2.UserId={$userId} AND t2.RoleId=t1.Id AND t2.IsDel=0)
            WHERE t1.IsDel=0 {$search} ORDER BY (CASE WHEN t2.Id IS NULL THEN 1 ELSE 0 END) ASC,t1.Sort ASC;");
            return toEasyTable($data);
        } catch (\Exception $e) {
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
                return jsonOut(config('code.error'), "参数错误");
            }
            $model = SysUserRoleModel::where(["UserId" => $userId, "RoleId" => $roleId])->find();
            if (empty($model)) {
                $model = new SysUserRoleModel();
                //新增关联插入记录
                $model->save(
                    ["UserId" => $userId,
                        "RoleId" => $roleId,
                        "CreateTime" => date("Y-m-d H:i:s"),
                        "CreateUser" => $this->user["Id"],
                        "ModifyTime" => date("Y-m-d H:i:s"),
                        "ModifyUser" => $this->user["Id"],
                    ]);
                return jsonOut(config('code.success'), "操作成功");
            }
            //更新可用状态
            $data = [
                'IsValid' => 1,
                'IsDel' => 0,
                "ModifyTime" => date("Y-m-d H:i:s"),
                "ModifyUser" => $this->user["Id"],
            ];
            //更新数据
            $model->save($data);
            return jsonOut(config('code.success'), "操作成功");
        } catch (\Exception $e) {
            return jsonOut(config('code.error'), $e->getMessage());
        }
    }

    //用户删除关联角色 Json
    public function delRelationRole()
    {
        try {
            $userId = input("userId") ?: 0;
            $roleId = input("roleId") ?: 0;
            if ($userId < 0 || $roleId < 0) {
                return jsonOut(config('code.error'), "参数错误");
            }
            $model = SysUserRoleModel::where(["UserId" => $userId, "RoleId" => $roleId])->find();
            if (empty($model)) {
                return jsonOut(config('code.error'), "未找到关联数据,无法删除关联");
            }
            //更新可用状态
            $data = [
                'IsValid' => 0,
                'IsDel' => 1,
                "ModifyTime" => date("Y-m-d H:i:s"),
                "ModifyUser" => $this->user["Id"],
            ];
            $model->save($data);
            return jsonOut(config('code.success'), "操作成功");
        } catch (\Exception $e) {
            return jsonOut(config('code.error'), $e->getMessage());
        }
    }
}
