
Tower API to do list:
1. assign work based on alarm event.
2. analyze which place has the most problem


 应用: Sewer_tracker
 应用 ID:

 71b9391a771b821c50caac1cf26a9b56475d258603ee9bf5ba4505a30988bb82
 私钥:

 d31a242fbd2d1722c1b16089f9bea622011389123b794535eeeb33537b60b768
 Scopes:

 Confidential:

 Access Token
 555f33781a5bb680a127ba8349140968853741c2774878bd93997d64965d25f5
 Token Type
 Bearer
 expires_in
 7199
 refresh_token
 22d8bd10af5042bde10f7f430da533c4c0c98ce726078134384a867d740ebfb8

 true
 登录回调地址:
 https://www.getpostman.com/oauth2/callback 	
 urn:ietf:wg:oauth:2.0:oob


 urn:ietf:wg:oauth:2.0:oob
https://www.getpostman.com/oauth2/callback

https://app.getpostman.com/oauth2/callback?code=da2069c04f3795dd41f15339662b63d2e95e7ee7c50c664aa5e541b16770619e

Token Name
Tower API Token
Access Token
593aeb6ce5fd0da29332dee45ed59c18b84f82ec93b67409068f8ba40c7a5d04
Token Type
Bearer
expires_in
7200
refresh_token
0a812c380a7868e5eb4959252ae64c8e840f02f2bf5b48e04c7fbe894804298d
created_at
1543820412
email
movive32@hotmail.com

{
    "data": [
        {
            "id": "accdcb9c63e091b716bee1ccf25e11de",
            "type": "teams",
            "attributes": {
                "name": "movive",
                "created_at": "2018-12-03T11:48:34.000+08:00",
                "updated_at": "2018-12-03T11:48:45.000+08:00"
            }
        }
    ],
    "jsonapi": {
        "version": "1.0"
    }
}

{
    "data": [
        {
            "id": "ba4f95a13b98040d668291289741abb4",
            "type": "members",
            "attributes": {
                "nickname": "杜鹏",
                "is_active": true,
                "gavatar": "https://avatar-alioss.tower.im/letter_avatars/31f7b7c3eefa1f6d6748d63c82399b55_dupeng",
                "role": "member",
                "comment": null,
                "mailbox": null,
                "phone": null,
                "is_incomplete_from_wxwork": false,
                "is_locked_by_free_team_quota": false
            },
            "relationships": {
                "team": {
                    "data": {
                        "id": "accdcb9c63e091b716bee1ccf25e11de",
                        "type": "teams"
                    }
                },
                "groups": {
                    "data": []
                }
            }
        },
        {
            "id": "42512f40b0328d4d9f96a5f774c0fe1c",
            "type": "members",
            "attributes": {
                "nickname": "movive",
                "is_active": true,
                "gavatar": "https://avatar-alioss.tower.im/letter_avatars/7d56d3d837229db2675ef03ff27910fc_movive",
                "role": "owner",
                "comment": null,
                "mailbox": "movive32@hotmail.com",
                "phone": null,
                "is_incomplete_from_wxwork": false,
                "is_locked_by_free_team_quota": false
            },
            "relationships": {
                "team": {
                    "data": {
                        "id": "accdcb9c63e091b716bee1ccf25e11de",
                        "type": "teams"
                    }
                },
                "groups": {
                    "data": []
                }
            }
        },
        {
            "id": "d90554a0332c3d11b13bd059b3d2f8e7",
            "type": "members",
            "attributes": {
                "nickname": "张文娟",
                "is_active": true,
                "gavatar": "https://avatar-alioss.tower.im/letter_avatars/c8ed02743ee1184614acb6869494ba1a_zhangwenjuan",
                "role": "member",
                "comment": null,
                "mailbox": null,
                "phone": null,
                "is_incomplete_from_wxwork": false,
                "is_locked_by_free_team_quota": false
            },
            "relationships": {
                "team": {
                    "data": {
                        "id": "accdcb9c63e091b716bee1ccf25e11de",
                        "type": "teams"
                    }
                },
                "groups": {
                    "data": []
                }
            }
        }
    ],
    "included": [
        {
            "id": "accdcb9c63e091b716bee1ccf25e11de",
            "type": "teams",
            "attributes": {
                "name": "movive",
                "created_at": "2018-12-03T11:48:34.000+08:00",
                "updated_at": "2018-12-03T11:48:45.000+08:00"
            }
        }
    ],
    "jsonapi": {
        "version": "1.0"
    },
    "links": {
        "self": "https://tower.im/api/v1/teams/accdcb9c63e091b716bee1ccf25e11de/members?page%5Bnumber%5D=1&page%5Bsize%5D=200",
        "first": "https://tower.im/api/v1/teams/accdcb9c63e091b716bee1ccf25e11de/members?page%5Bnumber%5D=1&page%5Bsize%5D=200",
        "prev": null,
        "next": null,
        "last": "https://tower.im/api/v1/teams/accdcb9c63e091b716bee1ccf25e11de/members?page%5Bnumber%5D=1&page%5Bsize%5D=200"
    }
}
{
    "data": [
        {
            "id": "d27dfb31bedefa785f937d265736553c",
            "type": "projects",
            "attributes": {
                "name": "熟悉 Tower",
                "desc": "工欲善其事，必先利其器。",
                "is_pinned": false,
                "is_archived": false,
                "color_id": 1,
                "icon_id": 0
            },
            "relationships": {
                "project_groups": {
                    "data": []
                }
            }
        },
        {
            "id": "5c30310036fa776003588e1884787caf",
            "type": "projects",
            "attributes": {
                "name": "test",
                "desc": "",
                "is_pinned": false,
                "is_archived": false,
                "color_id": 2,
                "icon_id": 12
            },
            "relationships": {
                "project_groups": {
                    "data": []
                }
            }
        },
        {
            "id": "7f2a692e8f0a27fc6a30b4a0a4dec668",
            "type": "projects",
            "attributes": {
                "name": "Sewer_tracker",
                "desc": "管网水质监控",
                "is_pinned": false,
                "is_archived": false,
                "color_id": 2,
                "icon_id": 11
            },
            "relationships": {
                "project_groups": {
                    "data": []
                }
            }
        }
    ],
    "jsonapi": {
        "version": "1.0"
    }
}

{
    "data": [
        {
            "id": "6ea3f609769f8cb0a91800a3de1a622a",
            "type": "todolists",
            "attributes": {
                "name": "完成任务",
                "desc": "",
                "is_active": true,
                "is_archived": false,
                "is_default": false,
                "position": 4
            },
            "relationships": {
                "todos": {
                    "data": []
                }
            }
        },
        {
            "id": "5c7fbdef5864aee6c77e1edd2e6fbb13",
            "type": "todolists",
            "attributes": {
                "name": "在办任务",
                "desc": "",
                "is_active": true,
                "is_archived": false,
                "is_default": false,
                "position": 3
            },
            "relationships": {
                "todos": {
                    "data": []
                }
            }
        },
        {
            "id": "90a1b78a94f82f3aeb2d815a26023069",
            "type": "todolists",
            "attributes": {
                "name": "待办任务",
                "desc": "",
                "is_active": true,
                "is_archived": false,
                "is_default": false,
                "position": 2
            },
            "relationships": {
                "todos": {
                    "data": [
                        {
                            "id": "7c24aafc121fa78a621b27978f7798b4",
                            "type": "todos"
                        }
                    ]
                }
            }
        },
        {
            "id": "c59558f2fc27336166a4210aa0875c81",
            "type": "todolists",
            "attributes": {
                "name": "清单外任务",
                "desc": null,
                "is_active": true,
                "is_archived": false,
                "is_default": true,
                "position": 0
            },
            "relationships": {
                "todos": {
                    "data": []
                }
            }
        }
    ],
    "included": [
        {
            "id": "7c24aafc121fa78a621b27978f7798b4",
            "type": "todos",
            "attributes": {
                "content": "#位置1# 水质超标风险",
                "desc": "",
                "is_active": true,
                "is_completed": false,
                "due_at": "2018-12-04T23:59:59.000+08:00",
                "closed_at": null
            },
            "relationships": {
                "creator": {
                    "data": {
                        "id": "42512f40b0328d4d9f96a5f774c0fe1c",
                        "type": "members"
                    }
                },
                "assignee": {
                    "data": {
                        "id": "42512f40b0328d4d9f96a5f774c0fe1c",
                        "type": "members"
                    }
                },
                "closer": {
                    "data": null
                }
            }
        },
        {
            "id": "42512f40b0328d4d9f96a5f774c0fe1c",
            "type": "members",
            "attributes": {
                "nickname": "movive",
                "is_active": true,
                "gavatar": "https://avatar-alioss.tower.im/letter_avatars/7d56d3d837229db2675ef03ff27910fc_movive",
                "role": "owner"
            }
        }
    ],
    "jsonapi": {
        "version": "1.0"
    }
}
