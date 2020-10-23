package com.unknown.hrms.realm;

import com.unknown.hrms.dao.IUserMapper;
import com.unknown.hrms.entity.User;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.Permission;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Set;

public class UserRealm  extends AuthorizingRealm {

    @Autowired
    private IUserMapper userMapper;

    //用户授权

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        String username = (String)principalCollection.getPrimaryPrincipal();
        User user = new User();
        user.setUsername(username);
        User user1 = userMapper.selectOne(user);
        Set<String> permissionCode = userMapper.getPersByUserId(user1.getId());
        System.out.println(permissionCode);
        SimpleAuthorizationInfo authentizationInfo = new SimpleAuthorizationInfo();
        authentizationInfo.setStringPermissions(permissionCode);
        return authentizationInfo;
    }

    //用户认证
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        UsernamePasswordToken usernamePasswordToken = (UsernamePasswordToken) token;
        String username = usernamePasswordToken.getUsername();
        String password = String.valueOf(usernamePasswordToken.getPassword());
        User user = userMapper.selectUserByUsername(username);
        if(user == null) {
            throw new AccountException("账号或密码错误");
        }
        if(!password.equals(user.getPassword())){
            throw new AccountException("账号或密码错误");
        }
        SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(
                user.getUsername(), user.getPassword(), "a");
        return simpleAuthenticationInfo;
    }
}
