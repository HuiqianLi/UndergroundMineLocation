import com.unknown.hrms.entity.User;
import com.unknown.hrms.service.IUserService;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.Set;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:applictionContext.xml"})
public class UserTest {
    @Resource
    private IUserService userService;

    @Test
    public void testByUsername(){
        String username = "admin";
        User user = userService.selectUserByUsername(username);
        String pwdSalt = new Md5Hash(user.getPassword(),user.getUsername(),1024).toString();
        System.out.println(user+"加密后"+pwdSalt);
    }

    @Test
    public void testGetPermByUserId(){
        int id = 1;
        Set<String> permissionCode = userService.getPersByUserId(id);
        System.out.println(permissionCode);
    }
}
