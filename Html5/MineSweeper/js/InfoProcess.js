//CellInfo
//M:mine S:status N:number
//M false-none true-mine 
//S 0-normal 1-flag 2-ask 3-open 4-mine_no_flag 5-mine_flaged 6-mine_exploded 7-no_mine_but_flaged
//N 0-close >0-show mine number
function CellInfo(m, s, n) {
    this.M = m;
    this.S = s;
    this.N = n;
}
CellInfo.prototype.Clone = function () {
    return new CellInfo(this.M, this.S, this.N);
}

//MineInfo
function MineInfo(x, y, mine, isData) {
    this.X = x;
    this.Y = y;
    this.Mine = mine;
    this.Data = null;
    if (isData != null && isData == false) return;
    this.BuildData();
    this.GenerateMine();
}
MineInfo.prototype.BuildData = function () {
    this.Data = new Array();
    for (var x = 0; x < this.X; x++) {
        this.Data[x] = new Array();
        for (var y = 0; y < this.Y; y++) {
            this.Data[x][y] = new CellInfo(false, 0, 0);
        }
    }
}
MineInfo.prototype.CleanMine = function () {
    if (this.Data == null) return;
    for (var x = 0; x < this.X; x++)
        for (var y = 0; y < this.Y; y++)
            this.Data[x][y].M = false;
}
MineInfo.prototype.GenerateMine = function () {
    if (this.Data == null) return;
    if (this.Mine > this.X * this.Y) return;
    var mine = 0;
    while (mine < this.Mine) {
        var x = parseInt(Math.random() * 10000) % this.X;
        var y = parseInt(Math.random() * 10000) % this.Y;
        if (!this.Data[x][y].M) {
            this.Data[x][y].M = true;
            mine++;
        }
    }
}
MineInfo.prototype.Clone = function () {
    var mineInfo = new MineInfo(this.X, this.Y, this.Mine, false);
    mineInfo.Data = new Array();
    for (var x = 0; x < this.X; x++) {
        mineInfo.Data[x] = new Array();
        for (var y = 0; y < this.Y; y++) {
            mineInfo.Data[x][y] = this.Data[x][y].Clone();
        }
    }
    return mineInfo;
}

//InfoProcess
function InfoProcess(mineInfo, winHandler, loseHandler, cellChangeHandler, cellShakeDownHandler, cellShakeUpHandler, mineChangeHandler, context) {
    this.MineInfo = mineInfo;
    this.CurrentMine = mineInfo.Mine;
    this.WinHandler = winHandler;
    this.LoseHandler = loseHandler;
    this.CellChangeHandler = cellChangeHandler;
    this.CellShakeDownHandler = cellShakeDownHandler;
    this.CellShakeUpHandler = cellShakeUpHandler;
    this.MineChangeHandler = mineChangeHandler;
    this.Context = context;
}
InfoProcess.prototype.HandlerIsValidated = function (handler) {
    return !(handler == null || typeof (handler) != "function");
}
InfoProcess.prototype.CellIsValidated = function (x, y) {
    return !(x < 0 || x >= this.MineInfo.X || y < 0 || y >= this.MineInfo.Y);
}
InfoProcess.prototype.OnCellChange = function (x, y) {
    if (this.HandlerIsValidated(this.CellChangeHandler))
        this.CellChangeHandler(this.MineInfo, x, y, this.Context);
}
InfoProcess.prototype.OnCellShakeDown = function (list) {
    if (this.HandlerIsValidated(this.CellShakeDownHandler))
        this.CellShakeDownHandler(this.MineInfo, list, this.Context);
}
InfoProcess.prototype.OnCellShakeUp = function (list) {
    if (this.HandlerIsValidated(this.CellShakeUpHandler))
        this.CellShakeUpHandler(this.MineInfo, list, this.Context);
}
InfoProcess.prototype.OnLose = function (x, y) {
    if (this.HandlerIsValidated(this.LoseHandler))
        this.LoseHandler(this.MineInfo, x, y, this.Context);
}
InfoProcess.prototype.OnMineChange = function (x, y) {
    if (this.HandlerIsValidated(this.MineChangeHandler))
        this.MineChangeHandler(this.CurrentMine, x, y, this.Context);
}
InfoProcess.prototype.OnWin = function (x, y) {
    if (this.HandlerIsValidated(this.WinHandler))
        this.WinHandler(this.MineInfo, x, y, this.Context);
}
InfoProcess.prototype.GetMineNumber = function (x, y) {
    var result = 0;
    if (this.CellIsValidated(x - 1, y - 1) && this.MineInfo.Data[x - 1][y - 1].M)
        result++;
    if (this.CellIsValidated(x - 1, y) && this.MineInfo.Data[x - 1][y].M)
        result++;
    if (this.CellIsValidated(x - 1, y + 1) && this.MineInfo.Data[x - 1][y + 1].M)
        result++;
    if (this.CellIsValidated(x, y - 1) && this.MineInfo.Data[x][y - 1].M)
        result++;
    if (this.CellIsValidated(x, y + 1) && this.MineInfo.Data[x][y + 1].M)
        result++;
    if (this.CellIsValidated(x + 1, y - 1) && this.MineInfo.Data[x + 1][y - 1].M)
        result++;
    if (this.CellIsValidated(x + 1, y) && this.MineInfo.Data[x + 1][y].M)
        result++;
    if (this.CellIsValidated(x + 1, y + 1) && this.MineInfo.Data[x + 1][y + 1].M)
        result++;
    return result;
}
InfoProcess.prototype.SerachMine = function (x, y) {
    if (!this.CellIsValidated(x, y))
        return;
    if (this.MineInfo.Data[x][y].S != 0)
        return;
    if (!this.MineInfo.Data[x][y].M) {
        var mineNumber = this.GetMineNumber(x, y);
        if (mineNumber == 0) {
            this.MineInfo.Data[x][y].S = 3;
            this.OnCellChange(x, y);
            this.SerachMine(x - 1, y - 1);
            this.SerachMine(x - 1, y);
            this.SerachMine(x - 1, y + 1);
            this.SerachMine(x, y - 1);
            this.SerachMine(x, y + 1);
            this.SerachMine(x + 1, y - 1);
            this.SerachMine(x + 1, y);
            this.SerachMine(x + 1, y + 1);
        }
        else {
            this.MineInfo.Data[x][y].S = 3;
            this.MineInfo.Data[x][y].N = mineNumber;
            this.OnCellChange(x, y);
        }
    }
    else //mine, game over.
    {
        this.MineInfo.Data[x][y].S = 6;
        this.OnCellChange(x, y);
        this.SetLose(x, y);
    }
}
InfoProcess.prototype.SetLose = function (x, y) {
    for (var m = 0; m < this.MineInfo.X; m++)
        for (var n = 0; n < this.MineInfo.Y; n++)
            if (this.MineInfo.Data[m][n].M) {
                if (this.MineInfo.Data[m][n].S != 1 && this.MineInfo.Data[m][n].S != 6) {
                    this.MineInfo.Data[m][n].S = 4;
                    this.OnCellChange(m, n);
                }
                else if (this.MineInfo.Data[m][n].S == 1) {
                    this.MineInfo.Data[m][n].S = 5;
                    this.OnCellChange(m, n);
                }
            }
            else {
                if (this.MineInfo.Data[m][n].S == 1) {
                    this.MineInfo.Data[m][n].S = 7;
                    this.OnCellChange(m, n);
                }
            }
    this.OnLose(x, y);
}
InfoProcess.prototype.JudgeWin = function () {
    if (this.CurrentMine != 0)
        return false;
    for (var x = 0; x < this.MineInfo.X; x++)
        for (var y = 0; y < this.MineInfo.Y; y++)
            if (this.MineInfo.Data[x][y].M && this.MineInfo.Data[x][y].S != 1)
                return false;
    return true;
}
InfoProcess.prototype.MarkMine = function (x, y) {
    if (!this.CellIsValidated(x, y))
        return;
    var isWin = false;
    if (this.MineInfo.Data[x][y].S == 0) {
        this.MineInfo.Data[x][y].S = 1;
        this.CurrentMine--;
        this.OnMineChange(x, y);
        isWin = this.JudgeWin();
    }
    else if (this.MineInfo.Data[x][y].S == 1) {
        this.MineInfo.Data[x][y].S = 2;
        this.CurrentMine++;
        this.OnMineChange(x, y);
        isWin = this.JudgeWin();
    }
    else if (this.MineInfo.Data[x][y].S == 2) {
        this.MineInfo.Data[x][y].S = 0;
    }
    this.OnCellChange(x, y);
    if (isWin)
        this.OnWin(x, y);
}

InfoProcess.prototype.GetShakeInfo = function (x, y) {
    if (this.MineInfo.Data[x][y].S == 3 && this.MineInfo.Data[x][y].N == 0)
        return null;

    var list = new Array();
    if (this.CellIsValidated(x - 1, y - 1))
        list.push({ X: x - 1, Y: y - 1 });
    if (this.CellIsValidated(x - 1, y))
        list.push({ X: x - 1, Y: y });
    if (this.CellIsValidated(x - 1, y + 1))
        list.push({ X: x - 1, Y: y + 1 });
    if (this.CellIsValidated(x, y - 1))
        list.push({ X: x, Y: y - 1 });
    if (this.CellIsValidated(x, y + 1))
        list.push({ X: x, Y: y + 1 });
    if (this.CellIsValidated(x + 1, y - 1))
        list.push({ X: x + 1, Y: y - 1 });
    if (this.CellIsValidated(x + 1, y))
        list.push({ X: x + 1, Y: y });
    if (this.CellIsValidated(x + 1, y + 1))
        list.push({ X: x + 1, Y: y + 1 });

    var count = 0;
    var result = new Array();

    for (var i = 0; i < list.length; i++) {
        var status = this.MineInfo.Data[list[i].X][list[i].Y].S;
        if (status == 1)
            count++;
        if (status == 0)
            result.push(list[i]);
    }

    result.Marked = count;
    return result;
}

InfoProcess.prototype.CheckCellHasShake = function (x, y) {
    var result = this.GetShakeInfo(x, y);
    if (result == null || result.length == 0)
        return;

    if (result.Marked != this.MineInfo.Data[x][y].N) {
        this.OnCellShakeDown(result)
    }
}
InfoProcess.prototype.TryShakeCell = function (x, y) {
    var result = this.GetShakeInfo(x, y);
    if (result == null || result.length == 0)
        return;

    if (result.Marked != this.MineInfo.Data[x][y].N) {
        this.OnCellShakeUp(result)
    }
    else {
        for (var i = 0; i < result.length; i++) {
            if (this.MineInfo.Data[result[i].X][result[i].Y].S == 0) {
                this.SerachMine(result[i].X, result[i].Y);
            }
        }
    }
}
InfoProcess.prototype.ResumeCell = function () {
    for (var x = 0; x < this.MineInfo.X; x++)
        for (var y = 0; y < this.MineInfo.Y; y++)
            this.OnCellChange(x, y);
}

//GameStatus
function GameStatus(isStart, isPause, costTime) {
    this.IsStart = isStart;
    this.IsPause = isPause;
    this.CostTime = costTime;
}
GameStatus.prototype.Clone = function () {
    return new GameStatus(this.IsStart, this.IsPause, this.CostTime);
}

//GameInfo
function GameInfo(mineInfo, gameStatus) {
    this.MineInfo = mineInfo;
    this.GameStatus = gameStatus;
}
GameInfo.prototype.Clone = function () {
    return new GameInfo(this.MineInfo.Clone(), this.GameStatus.Clone());
}
