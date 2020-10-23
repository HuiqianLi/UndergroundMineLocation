import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.unknown.hrms.entity.Emp;
import com.unknown.hrms.service.IEmpService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:applictionContext.xml"})
public class authTest {
    @Autowired
    private IEmpService empService;

    @Test
    public void testUpdataEmp(){
        EntityWrapper<Emp> empEntityWrapper = new EntityWrapper<Emp>();
        List<Integer> ids = new ArrayList<Integer>(1);
        empEntityWrapper.in("id",ids);
        Integer orgId = 17;
        empService.updateForSet("orgno ="+orgId,empEntityWrapper);
    }
}
