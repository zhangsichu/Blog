function Game(gameInfo, infoProcess, mineArea, gameTimeLapseHandler, startGameHandler, stopGameHandler, pauseGameHandler, resumeGameHandler, winHandler, loseHandler, mineChangeHandler, generateUIHandler) {
    this.GameInfo = gameInfo;
    this.InfoProcess = infoProcess;
    this.MineArea = mineArea;
    this.TimeLapseTicket = null;

    this.GameTimeLapseHandler = gameTimeLapseHandler;
    this.StartGameHandler = startGameHandler;
    this.StopGameHandler = stopGameHandler;
    this.PauseGameHandler = pauseGameHandler;
    this.ResumeGameHandler = resumeGameHandler;

    this.WinHandler = winHandler;
    this.LoseHandler = loseHandler;
    this.MineChangeHandler = mineChangeHandler;
    this.GenerateUIHandler = generateUIHandler;

    //================================
    //InfoProcess: winHandler, loseHandler, cellChangeHandler, cellShakeDownHandler, cellShakeUpHandler, mineChangeHandler;
    //================================
    this.InfoProcess.WinHandler = Function.prototype.CreateDelegate(this, function (mineInfo, x, y, context) {
        this.StopGame();
        this.OnWin(mineInfo, this.GameInfo.GameStatus.CostTime, x, y, context);
    });

    this.InfoProcess.LoseHandler = Function.prototype.CreateDelegate(this, function (mineInfo, x, y, context) {
        this.StopGame();
        this.OnLose(mineInfo, this.GameInfo.GameStatus.CostTime, x, y, context);
    });

    this.InfoProcess.CellChangeHandler = Function.prototype.CreateDelegate(this, function (mineInfo, x, y, context) {
        this.RenderOneCellByMineInfo(mineInfo, x, y, this.MineArea.GetMineAreaCellRender());
    });

    this.InfoProcess.CellShakeDownHandler = Function.prototype.CreateDelegate(this, function (mineInfo, list, context) {
        var cellRender = this.MineArea.GetMineAreaCellRender();
        for (var i = 0; i < list.length; i++) {
            cellRender.RenderEmpty(list[i].X, list[i].Y);
        }
    });

    this.InfoProcess.CellShakeUpHandler = Function.prototype.CreateDelegate(this, function (mineInfo, list, context) {
        var cellRender = this.MineArea.GetMineAreaCellRender();
        for (var i = 0; i < list.length; i++) {
            this.RenderOneCellByMineInfo(mineInfo, list[i].X, list[i].Y, this.MineArea.GetMineAreaCellRender());
        }
    });

    this.InfoProcess.MineChangeHandler = Function.prototype.CreateDelegate(this, function (currentMine, x, y, context) {
        this.OnMineChange(currentMine, x, y, context);
    });

    //================================
    //MineArea: cellDoubleDownHandler, cellDoubleUpHandler, cellLeftDownHandler, cellLeftUpHandler, cellRightDownHandler, cellRightUpHandler, beforeActiveCellChangeHandler, afterActiveCellChangeHandler;
    //================================
    this.MineArea.CellDoubleDownHandler = Function.prototype.CreateDelegate(this, function (lastActiveCell) {
        if (!this.GameIsAlive())
            return;

        this.InfoProcess.CheckCellHasShake(lastActiveCell.X, lastActiveCell.Y);
    });

    this.MineArea.CellDoubleUpHandler = Function.prototype.CreateDelegate(this, function (lastActiveCell) {
        if (!this.GameIsAlive())
            return;

        this.InfoProcess.TryShakeCell(lastActiveCell.X, lastActiveCell.Y);
    });

    this.MineArea.CellLeftDownHandler = Function.prototype.CreateDelegate(this, function (lastActiveCell) {
        if (!this.GameIsAlive())
            return;

        if (this.GameInfo.MineInfo.Data[lastActiveCell.X][lastActiveCell.Y].S != 0)
            return;

        this.MineArea.GetMineAreaCellRender().RenderEmpty(lastActiveCell.X, lastActiveCell.Y);
    });

    this.MineArea.CellLeftUpHandler = Function.prototype.CreateDelegate(this, function (lastActiveCell) {
        if (!this.GameIsAlive())
            return;

        this.InfoProcess.SerachMine(lastActiveCell.X, lastActiveCell.Y);
    });

    this.MineArea.CellRightDownHandler = Function.prototype.CreateDelegate(this, function (lastActiveCell) {
        if (!this.GameIsAlive())
            return;

        if (this.GameInfo.MineInfo.Data[lastActiveCell.X][lastActiveCell.Y].S != 0)
            return;

        this.MineArea.GetMineAreaCellRender().RenderEmpty(lastActiveCell.X, lastActiveCell.Y);
    });

    this.MineArea.CellRightUpHandler = Function.prototype.CreateDelegate(this, function (lastActiveCell) {
        if (!this.GameIsAlive())
            return;

        this.InfoProcess.MarkMine(lastActiveCell.X, lastActiveCell.Y);
    });

    this.MineArea.BeforeActiveCellChangeHandler = Function.prototype.CreateDelegate(this, function (lastActiveCell) {
        if (!this.GameIsAlive())
            return;

        if (lastActiveCell.X >= this.GameInfo.MineInfo.X || lastActiveCell.Y >= this.GameInfo.MineInfo.Y)
            return;

        if (this.GameInfo.MineInfo.Data[lastActiveCell.X][lastActiveCell.Y].S == 0) {
            this.MineArea.GetMineAreaCellRender().RenderNormal(lastActiveCell.X, lastActiveCell.Y);
        }
    });

    this.MineArea.AfterActiveCellChangeHandler = Function.prototype.CreateDelegate(this, function (lastActiveCell) {
        if (!this.GameIsAlive())
            return;

        if (lastActiveCell.X >= this.GameInfo.MineInfo.X || lastActiveCell.Y >= this.GameInfo.MineInfo.Y)
            return;

        if (this.GameInfo.MineInfo.Data[lastActiveCell.X][lastActiveCell.Y].S == 0) {
            this.MineArea.GetMineAreaCellRender().RenderHighlight(lastActiveCell.X, lastActiveCell.Y);
        }
    });

    this.MineArea.MineAreaMouseOutHandler = Function.prototype.CreateDelegate(this, function (lastActiveCell) {
        if (!this.GameIsAlive())
            return;

        if (lastActiveCell.X >= this.GameInfo.MineInfo.X || lastActiveCell.Y >= this.GameInfo.MineInfo.Y)
            return;

        if (this.GameInfo.MineInfo.Data[lastActiveCell.X][lastActiveCell.Y].S == 0) {
            this.MineArea.GetMineAreaCellRender().RenderNormal(lastActiveCell.X, lastActiveCell.Y);
        }
    });
    this.OnMineChange(this.InfoProcess.CurrentMine);
    this.OnTimeLapse(this.GameInfo.GameStatus.CostTime);
}

Game.prototype.RenderOneCellByMineInfo = function (mineInfo, x, y, cellRender) {
    if (mineInfo.Data[x][y].S == 0)
        cellRender.RenderNormal(x, y);
    else if (mineInfo.Data[x][y].S == 1)
        cellRender.RenderFlag(x, y);
    else if (mineInfo.Data[x][y].S == 2)
        cellRender.RenderAsk(x, y);
    else if (mineInfo.Data[x][y].S == 3)
        if (mineInfo.Data[x][y].N > 0)
            switch (mineInfo.Data[x][y].N) {
            case 1:
                cellRender.RenderOne(x, y);
                break;
            case 2:
                cellRender.RenderTwo(x, y);
                break;
            case 3:
                cellRender.RenderThree(x, y);
                break;
            case 4:
                cellRender.RenderFour(x, y);
                break;
            case 5:
                cellRender.RenderFive(x, y);
                break;
            case 6:
                cellRender.RenderSix(x, y);
                break;
            case 7:
                cellRender.RenderSeven(x, y);
                break;
            case 8:
                cellRender.RenderEight(x, y);
                break;
            default:
                break;
        }
        else
            cellRender.RenderEmpty(x, y);
    else if (mineInfo.Data[x][y].S == 4)
        cellRender.RenderMine(x, y);
    else if (mineInfo.Data[x][y].S == 5)
        cellRender.RenderIncorrectMine(x, y);
    else if (mineInfo.Data[x][y].S == 6)
        cellRender.RenderExplodedMine(x, y);
    else if (mineInfo.Data[x][y].S == 7)
        cellRender.RenderIncorrectFlag(x, y);
}

Game.prototype.HandlerIsValidated = function (handler) {
    return !(handler == null || typeof (handler) != "function");
}

Game.prototype.GameIsAlive = function () {
    return this.GameInfo.GameStatus.IsStart && !this.GameInfo.GameStatus.IsPause;
}
Game.prototype.GenerateUI = function () {
    this.OnGenerateUI(this.GameInfo.MineInfo, this.MineArea);
    this.MineArea.Render(this.GameInfo.MineInfo.X, this.GameInfo.MineInfo.Y);
    window.document.oncontextmenu = function () { return false; };
    window.document.ondragstart = function () { return false; };
}
Game.prototype.StartGame = function () {
    this.GameInfo.GameStatus.IsPause = false;
    this.GameInfo.GameStatus.IsStart = true;
    this.TimeLapseTicket = window.setInterval(Function.CreateDelegate(this, this.InnerTimeLapseHandler), 1000);
    this.OnTimeLapse(this.GameInfo.GameStatus.CostTime);
    this.OnMineChange(this.InfoProcess.CurrentMine);
    this.OnStartGame();
}
Game.prototype.StopGame = function () {
    this.GameInfo.GameStatus.IsStart = false;
    if (this.TimeLapseTicket != null)
        window.clearInterval(this.TimeLapseTicket);
    this.OnStopGame();
}
Game.prototype.PauseGame = function () {
    this.GameInfo.GameStatus.IsPause = true;
    if (this.TimeLapseTicket != null)
        window.clearInterval(this.TimeLapseTicket);
    this.OnPauseGame();
}
Game.prototype.ResetGame = function () {
    this.StopGame();
    for (var y = 0; y < this.GameInfo.MineInfo.Y; y++)
        for (var x = 0; x < this.GameInfo.MineInfo.X; x++) {
            this.MineArea.GetMineAreaCellRender().RenderNormal(x, y);
            this.GameInfo.MineInfo.Data[x][y].S = 0;
            this.GameInfo.MineInfo.Data[x][y].N = 0;
        }
    this.GameInfo.GameStatus.CostTime = 0;
    this.InfoProcess.CurrentMine = this.GameInfo.MineInfo.Mine;
    this.StartGame();
}
Game.prototype.NewRound = function () {
    this.GameInfo.MineInfo.CleanMine();
    this.GameInfo.MineInfo.GenerateMine();
    this.ResetGame();
}
Game.prototype.NewGame = function (x, y, mine) {
    this.StopGame();
    var mineInfo = new MineInfo(x, y, mine);
    var gameStatus = new GameStatus(false, false, 0);
    this.GameInfo = new GameInfo(mineInfo, gameStatus);
    this.InfoProcess.MineInfo = mineInfo;
    this.InfoProcess.CurrentMine = mine;
    this.GenerateUI();
    this.StartGame();
}
Game.prototype.RandomGame = function () {
    var x = y = mine = 0;
    while (true) {
        x = parseInt(Math.random() * 10000) % 30;
        y = parseInt(Math.random() * 10000) % 30;
        mine = parseInt(Math.random() * 10000) % 30;
        if (x > 20 && y > 10 && y < 18 && mine > 10 && x * y > mine)
            break;
    }
    this.NewGame(x, y, mine);
}
Game.prototype.ResumeGame = function (storageInfo) {
    this.StopGame();
    this.GameInfo = storageInfo.GameInfo;
    this.InfoProcess.MineInfo = storageInfo.GameInfo.MineInfo;
    this.InfoProcess.CurrentMine = storageInfo.CurrentMine;
    this.GenerateUI();
    this.InfoProcess.ResumeCell();
    this.OnResumeGame(storageInfo);
    this.OnTimeLapse(storageInfo.GameInfo.GameStatus.CostTime);
    this.OnMineChange(storageInfo.CurrentMine);
    if (storageInfo.GameInfo.GameStatus.IsPause)
        this.PauseGame();
    else if (storageInfo.GameInfo.GameStatus.IsStart)
        this.StartGame();
}

Game.prototype.InnerTimeLapseHandler = function () {
    if (!this.GameInfo.GameStatus.IsStart || this.GameInfo.GameStatus.IsPause) return;
    this.GameInfo.GameStatus.CostTime++;
    this.OnTimeLapse(this.GameInfo.GameStatus.CostTime);
}

Game.prototype.OnTimeLapse = function (costTime) {
    if (this.HandlerIsValidated(this.GameTimeLapseHandler))
        this.GameTimeLapseHandler(costTime);
}
Game.prototype.OnStartGame = function () {
    if (this.HandlerIsValidated(this.StartGameHandler))
        this.StartGameHandler();
}
Game.prototype.OnStopGame = function () {
    if (this.HandlerIsValidated(this.StopGameHandler))
        this.StopGameHandler();
}
Game.prototype.OnPauseGame = function () {
    if (this.HandlerIsValidated(this.PauseGameHandler))
        this.PauseGameHandler();
}
Game.prototype.OnResumeGame = function (storageInfo) {
    if (this.HandlerIsValidated(this.ResumeGameHandler))
        this.ResumeGameHandler(storageInfo);
}
Game.prototype.OnWin = function (mineInfo, costTime, x, y, context) {
    if (this.HandlerIsValidated(this.WinHandler))
        this.WinHandler(mineInfo, costTime, x, y, context);
}
Game.prototype.OnLose = function (mineInfo, costTime, x, y, context) {
    if (this.HandlerIsValidated(this.LoseHandler))
        this.LoseHandler(mineInfo, costTime, x, y, context);
}
Game.prototype.OnMineChange = function (currentMine, x, y, context) {
    if (this.HandlerIsValidated(this.MineChangeHandler))
        this.MineChangeHandler(currentMine, x, y, context);
}
Game.prototype.OnGenerateUI = function (mineInfo, mineArea) {
    if (this.HandlerIsValidated(this.GenerateUIHandler))
        this.GenerateUIHandler(mineInfo, mineArea);
}
