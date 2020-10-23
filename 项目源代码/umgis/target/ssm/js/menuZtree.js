
function layer_show_menu(title,url,w,h){
    if (title == null || title == '') {
        title=false;
    };
    if (url == null || url == '') {
        url="404.html";
    };
    if (w == null || w == '') {
        w=800;
    };
    if (h == null || h == '') {
        h=($(window).height() - 50);
    };
    layer.open({
        type: 2, // 弹框框的类型，ifream
        area: [w+'px', h +'px'],
        fix: false, //不固定
        maxmin: true, //  最大最小化
        shade:0.4,
        title: title,
        content: url,
        end:function(){
            var menuId = $.session.get("menuId");
            var menuName = $.session.get("menuName");

            $("#menuId").val(menuId);
            $("#menuName").val(menuName);
        }
    });
}

/**
 * 把简单的JSON转成标准的JSON
 * @param json
 * @returns {Array}
 */
function format(json){
    var ret = [], o = {};

    function add(arr, data){
        var obj = {
            "id": data.id,
            "pId": data.pId,
            "name":data.name,
            "open":true,
            "children": [],
            "checked":data.checked
        };
        o[data.id] = obj;
        arr.push(obj);
    }

    json.forEach(x => {
        if(o[x.pId]){
            add(o[x.pId].children, x);
        }else{
            add(ret, x);
        }
    });
    return ret;
}