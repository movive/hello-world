import urllib.request,urllib.parse,json
url = 'https://hook.worktile.com/incoming/5ab76790cec046faa1cd58a27249c519'
postdata = {"text": "这是一条来自于Incoming Webhook的消息。\n并且消息还可以换行。"}

'''
{
    "action": "pick_post",
    "data"  : {
        "post_id"    : "post_id",
        "name"       : "name",
        "summary"    : "description",
        "content"    : "content",
        "create_date": 14109373736,
        "create_by"  : {
            "uid"         : "uid",
            "name"        : "name",
            "display_name": "display_name",
            "email"       : "email"
        },
        "project"    : {
            "pid" : "pid",
            "name": "name"
            }
        }
}
'''
headers = {
#    "User-Agent"         : "Worktile-WebHook-Server",
#    "X-Worktile-Delivery": "a3l0s9h3aloyh",
#    "X-Worktile-Event"   :  "pick_post",
    "Content-Type": "application/json"}
# data = postdata.encode('utf-8')
# data = urllib.parse.urlencode(postdata).encode('utf-8')

data = urllib.parse.urlencode(postdata).encode('utf-8')
# request = urllib.request.Request(url=url, headers=headers, json=json.dumps(postdata))
# request = urllib.request.Request(url=url, headers=headers, data=None)

request = urllib.request.Request(url=url, headers=headers, data=data)
responce = urllib.request.urlopen(request)

print(responce.read().decode('utf-8'))
