const https = require('https');
const accessToken = '555f33781a5bb680a127ba8349140968853741c2774878bd93997d64965d25f5';
module.exports.handler = function(event, context, callback) {
var eventJson = JSON.parse(event.toString());
//Tower消息格式
const postData = JSON.stringify({ 
        "todo": { 
        "content": "#" + eventJson.tag + "#发生水质超标！", 
        "desc": "1、前往" + eventJson.tag + "\n" +
        "2、采集水样，并以" + eventJson.time + "作为水样ID\n" +
        "3、估算井内流量\n" +
        "4、拍摄井内照片\n" +
        "5、观察现场有无排口，若没有排口则在任务标题中添加#无排口#字段\n" +
        "6、上传照片、水样ID和现场描述到任务中，点击完成任务", 
        "assignee_id": "42512f40b0328d4d9f96a5f774c0fe1c", 
        "due_at": eventJson.time 
        }
});

const options = {
hostname: 'tower.im',
port: 443,
path: '/api/v1/todolists/90a1b78a94f82f3aeb2d815a26023069/todos' // + accessToken,
method: 'POST',
headers: {
    'Authorization': 'Bearer ' + accessToken,
    'Content-type': 'application/json',
    'Content-Length': Buffer.byteLength(postData)
}
};
const req = https.request(options, (res) => {
res.setEncoding('utf8');
res.on('data', (chunk) => {});
res.on('end', () => {
callback(null, 'success');
});
});
// 异常返回
req.on('error', (e) => {
callback(e);
});
// 写入数据
req.write(postData);
req.end();
};

