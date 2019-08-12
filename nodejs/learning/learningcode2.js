var ReverseData = {
    W: 12,
    B: 11,
    N: 1,

    map: [
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0,
        0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0,
        0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0,
        0, 0, 0, 0, 1, 1, 1, 12, 11, 1, 1, 1, 0, 0, 0, 0,
        0, 0, 0, 0, 1, 1, 1, 11, 12, 1, 1, 1, 0, 0, 0, 0,
        0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0,
        0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0,
        0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    ],

    i2m: [
        68, 69, 70, 71, 72, 73, 74, 75,
        84, 85, 86, 87, 88, 89, 90, 91,
        100, 101, 102, 103, 104, 105, 106, 107,
        116, 117, 118, 119, 120, 121, 122, 123,
        132, 133, 134, 135, 136, 137, 138, 139,
        148, 149, 150, 151, 152, 153, 154, 155,
        164, 165, 166, 167, 168, 169, 170, 171,
        180, 181, 182, 183, 184, 185, 186, 187
    ],

    m2i: [
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 0, 0, 0, 0,
        0, 0, 0, 0, 8, 9, 10, 11, 12, 13, 14, 15, 0, 0, 0, 0,
        0, 0, 0, 0, 16, 17, 18, 19, 20, 21, 22, 23, 0, 0, 0, 0,
        0, 0, 0, 0, 24, 25, 26, 27, 28, 29, 30, 31, 0, 0, 0, 0,
        0, 0, 0, 0, 32, 33, 34, 35, 36, 37, 38, 39, 0, 0, 0, 0,
        0, 0, 0, 0, 40, 41, 42, 43, 44, 45, 46, 47, 0, 0, 0, 0,
        0, 0, 0, 0, 48, 49, 50, 51, 52, 53, 54, 55, 0, 0, 0, 0,
        0, 0, 0, 0, 56, 57, 58, 59, 60, 61, 62, 63, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    ],

    step: [-17, -16, -15, -1, 1, 15, 16, 17],
    kStep: [-9, -8, -7, -1, 1, 7, 8, 9]
};

function Reverse(param) {
    param = typeof param === "object" ? param : {};

    typeof param.afterClick === "function" || (param.afterClick = function () { });
    this.callback_afterClick = param.afterClick;

    this.DOM = param.dom;
    this.jDOM = $(param.dom);

    this.position = ReverseData.map.slice(0);
    this.currentPlayer = 11;
    this.stepList = [];

    this.createBoard();
    this.bindClick();
    this.render();
    this.reloadLegalTips();
}

Reverse.prototype.createBoard = function () {
    for (var i = 0; i < 64; ++i) {
        this.jDOM.append('<div class="piece">' + i + '<div class="circle w"></div><div class="circle b"></div></div>');
    }

    this.piecejDOM = this.jDOM.children('.piece');
};

Reverse.prototype.render = function () {
    this.piecejDOM.removeClass("W B");

    for (var i = 0; i < 64; ++i) {
        var mapK = ReverseData.i2m[i];
        var piece = this.position[mapK];

        switch (piece) {
            case ReverseData.W: this.piecejDOM.eq(i).addClass("W"); break;
            case ReverseData.B: this.piecejDOM.eq(i).addClass("B"); break;
        }
    }
};

Reverse.prototype.bindClick = function () {
    var _this = this;

    this.piecejDOM.each(function (i) {
        $(this).bind("click", function () {
            _this.putPiece(i, _this.currentPlayer);
            _this.render();
            _this.reloadLegalTips();
            _this.callback_afterClick();
        });
    });
};

Reverse.prototype.putPiece = function (i, piece) {
    if (!this.isLegal(i)) {
        return false;
    }

    var mapK = ReverseData.i2m[i];
    this.position[mapK] = this.currentPlayer;

    for (var j = 0; j < 8; ++j) {
        var k = ReverseData.step[j];
        this.eat(mapK, k);
    }

    this.stepList.push(i);
    this.currentPlayer = 23 - this.currentPlayer;

    // 第一次检测
    var legalLength = 0;

    for (var j = 0; j < 64; ++j) {
        if (this.isLegal(j)) {
            ++legalLength;
        }
    }

    if (legalLength === 0) {
        this.currentPlayer = 23 - this.currentPlayer;
    }

    // 第二次检测
    var legalLength = 0;

    for (var j = 0; j < 64; ++j) {
        if (this.isLegal(j)) {
            ++legalLength;
        }
    }

    if (legalLength === 0) {
        var wLength = 0;
        var bLength = 0;

        for (var j = 0; j < 64; ++j) {
            if (this.isW(j)) {
                ++wLength;
            }

            if (this.isB(j)) {
                ++bLength;
            }
        }

        setTimeout(function () {
            if (wLength > bLength) {
                alert("白棋赢！");
            }

            else if (wLength < bLength) {
                alert("黑棋赢！");
            }

            else {
                alert("和棋！");
            }
        }, 1000);
    }

    return this;
};

Reverse.prototype.isW = function (i) {
    var mapK = ReverseData.i2m[i];
    return this.position[mapK] === ReverseData.W;
};

Reverse.prototype.isB = function (i) {
    var mapK = ReverseData.i2m[i];
    return this.position[mapK] === ReverseData.B;
};

Reverse.prototype.isN = function (i) {
    var mapK = ReverseData.i2m[i];
    return this.position[mapK] === ReverseData.N;
};

Reverse.prototype.isPlayer = function (i) {
    var mapK = ReverseData.i2m[i];
    return this.position[mapK] === this.currentPlayer;
};

Reverse.prototype.isEnermy = function (i) {
    var mapK = ReverseData.i2m[i];
    return this.currentPlayer === 23 - this.position[mapK];
};

Reverse.prototype.hasEnermy = function (i, k) {
    return this.isEnermy(i + k);
};

Reverse.prototype.hasMyself = function (i, k) {
    var mapK = ReverseData.i2m[i];

    for (var m = mapK + k * 2; this.position[m]; m += k) {
        if (this.position[m] <= 1) {
            return false;
        }

        if (this.position[m] === this.currentPlayer) {
            return true;
        }
    }

    return false;
};

Reverse.prototype.isLegal = function (i) {
    if (!this.isN(i)) {
        return false;
    }

    for (var j = 0; j < 8; ++j) {
        var k = ReverseData.kStep[j];
        var K = ReverseData.step[j];

        if (this.isEnermy(i + k) && this.hasMyself(i, K)) {
            return true;
        }
    }

    return false;
};

Reverse.prototype.eat = function (i, k) {
    for (var j = i + k; this.position[j]; j += k) {
        if (this.position[j] <= 1) {
            break;
        }

        if (this.position[j] === this.currentPlayer) {
            for (var m = j; m !== i; m -= k) {
                if (this.position[m] > 1) {
                    this.position[m] = this.currentPlayer;
                }
            }

            break;
        }
    }

    return this;
};

Reverse.prototype.reloadLegalTips = function () {
    this.piecejDOM.removeClass("can");

    for (var j = 0; j < 64; ++j) {
        if (this.isLegal(j)) {
            this.piecejDOM.eq(j).addClass("can");
        }
    }

    return this;
};