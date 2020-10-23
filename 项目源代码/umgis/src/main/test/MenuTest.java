import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.unknown.hrms.entity.Menu;
import com.unknown.hrms.service.IMenuService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:applictionContext.xml"})
public class MenuTest {
    @Autowired
    private IMenuService menuService;
    @Test
    public void testMenu(){
        /*List<Menu> menus = menuService.selectList(null);
        for(Menu menu:menus){
            System.out.println(menu);
        }*/
        EntityWrapper<Menu> entityWrapper = new EntityWrapper<Menu>();
        entityWrapper.eq("type","1");
        //entityWrapper.eq("id","1");
        List<Menu> menus = menuService.selectList(entityWrapper);
        for(Menu menu:menus){
            System.out.println(menu);
        }
        /*EntityWrapper<Menu> entityWrapper = new EntityWrapper<Menu>();
        entityWrapper.eq("name","员工管理");
        //entityWrapper.eq("id","1");
        Menu menu = menuService.selectOne(entityWrapper);*/
    }
}
