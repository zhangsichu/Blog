function MineArea(canvas, cellSize, cellStyle, cellDoubleDownHandler, cellDoubleUpHandler, cellLeftDownHandler, cellLeftUpHandler, cellRightDownHandler, cellRightUpHandler, beforeActiveCellChangeHandler, afterActiveCellChangeHandler, mineAreaMouseOutHandler) {
    this.Canvas = canvas;
    this.CellSize = cellSize;
    this.CellStyle = cellStyle;

    this.CellDoubleDownHandler = cellDoubleDownHandler;
    this.CellDoubleUpHandler = cellDoubleUpHandler;
    this.CellLeftDownHandler = cellLeftDownHandler;
    this.CellLeftUpHandler = cellLeftUpHandler;
    this.CellRightDownHandler = cellRightDownHandler;
    this.CellRightUpHandler = cellRightUpHandler;
    this.BeforeActiveCellChangeHandler = beforeActiveCellChangeHandler;
    this.AfterActiveCellChangeHandler = afterActiveCellChangeHandler;
    this.MineAreaMouseOutHandler = mineAreaMouseOutHandler;

    this.Canvas.addEventListener('mousemove', Function.CreateDelegate(this, this.MouseMove), false);
    this.Canvas.addEventListener('mousedown', Function.CreateDelegate(this, this.MouseDown), false);
    this.Canvas.addEventListener('mouseup', Function.CreateDelegate(this, this.MouseUp), false);
    this.Canvas.addEventListener('mouseout', Function.CreateDelegate(this, this.MouseOut), false);

    this.LastActiveCell = null;
    this.InnerRender = new CellRender(this.Canvas.getContext('2d'), this.CellSize, this.CellStyle);
    this.ClickCount = 0;
}

MineArea.prototype.Render = function (mineWidth, mineHeight) {
    this.Canvas.width = mineWidth * this.CellSize;
    this.Canvas.height = mineHeight * this.CellSize;

    for (var i = 0; i < mineHeight; i++) {
        for (var j = 0; j < mineWidth; j++) {
            this.InnerRender.RenderNormal(j, i);
        }
    }
}

MineArea.prototype.GetMineAreaCellRender = function () {
    return this.InnerRender;
}
MineArea.prototype.ResetCellSizeTo = function (cellSize) {
    this.CellSize = cellSize;
    this.InnerRender.CellSize = cellSize;
}
MineArea.prototype.HandlerIsValidated = function (handler) {
    return !(handler == null || typeof (handler) != "function");
}

MineArea.prototype.OnCellDoubleDown = function (lastActiveCell) {
    if (this.HandlerIsValidated(this.CellDoubleDownHandler))
        this.CellDoubleDownHandler(lastActiveCell);
}

MineArea.prototype.OnCellDoubleUp = function (lastActiveCell) {
    if (this.HandlerIsValidated(this.CellDoubleUpHandler))
        this.CellDoubleUpHandler(lastActiveCell);
}

MineArea.prototype.OnCellLeftDown = function (lastActiveCell) {
    if (this.HandlerIsValidated(this.CellLeftDownHandler))
        this.CellLeftDownHandler(lastActiveCell);
}

MineArea.prototype.OnCellLeftUp = function (lastActiveCell) {
    if (this.HandlerIsValidated(this.CellLeftUpHandler))
        this.CellLeftUpHandler(lastActiveCell);
}

MineArea.prototype.OnCellRightDown = function (lastActiveCell) {
    if (this.HandlerIsValidated(this.CellRightDownHandler))
        this.CellRightDownHandler(lastActiveCell);
}

MineArea.prototype.OnCellRightUp = function (lastActiveCell) {
    if (this.HandlerIsValidated(this.CellRightUpHandler))
        this.CellRightUpHandler(lastActiveCell);
}

MineArea.prototype.OnCellRightUp = function (lastActiveCell) {
    if (this.HandlerIsValidated(this.CellRightUpHandler))
        this.CellRightUpHandler(lastActiveCell);
}

MineArea.prototype.OnCellRightUp = function (lastActiveCell) {
    if (this.HandlerIsValidated(this.CellRightUpHandler))
        this.CellRightUpHandler(lastActiveCell);
}

MineArea.prototype.OnBeforeActiveCellChange = function (lastActiveCell) {
    if (this.HandlerIsValidated(this.BeforeActiveCellChangeHandler))
        this.BeforeActiveCellChangeHandler(lastActiveCell);
}

MineArea.prototype.OnAfterActiveCellChange = function (lastActiveCell) {
    if (this.HandlerIsValidated(this.AfterActiveCellChangeHandler))
        this.AfterActiveCellChangeHandler(lastActiveCell);
}

MineArea.prototype.OnMineAreaMouseOut = function (lastActiveCell) {
    if (this.HandlerIsValidated(this.MineAreaMouseOutHandler))
        this.MineAreaMouseOutHandler(lastActiveCell);
}

MineArea.prototype.MouseMove = function (e) {
    var x, y;
    if (e.pageX || e.pageX == 0) {
        x = e.pageX - this.Canvas.offsetLeft;
        y = e.pageY - this.Canvas.offsetTop;
    }
    else if (e.offsetX || e.offsetX == 0) {
        x = e.offsetX;
        y = e.offsetY;
    }
    var indexX = x / this.CellSize;
    var indexY = y / this.CellSize;

    indexX = Math.floor(indexX);
    indexY = Math.floor(indexY);

    if (this.LastActiveCell == null ||
                this.LastActiveCell.X != indexX || this.LastActiveCell.Y != indexY) {
        this.ClickCount = 0;

        if (this.LastActiveCell != null)
            this.OnBeforeActiveCellChange(this.LastActiveCell);

        this.LastActiveCell = { X: indexX, Y: indexY };

        this.OnAfterActiveCellChange(this.LastActiveCell);
    }
}

MineArea.prototype.MouseDown = function (e) {
    e.preventDefault();
    this.ClickCount++;
    if (this.ClickCount == 2) { // two button click
        this.OnCellDoubleDown(this.LastActiveCell);
    }
    else if (this.ClickCount == 1) { // one button click
        if (e == null) e = window.event;
        if (e.button != 2)
            this.OnCellLeftDown(this.LastActiveCell); // left button
        else
            this.OnCellRightDown(this.LastActiveCell); // right button
    }
}

MineArea.prototype.MouseUp = function (e) {
    e.preventDefault();
    if (this.ClickCount == 2) { // two button click
        this.ClickCount = 0;
        this.OnCellDoubleUp(this.LastActiveCell);
    }
    else if (this.ClickCount == 1) { // one button click
        this.ClickCount = 0;
        if (e == null) e = window.event;
        if (e.button != 2)
            this.OnCellLeftUp(this.LastActiveCell); // left button
        else
            this.OnCellRightUp(this.LastActiveCell); // right button
    }
    this.ClickCount = 0;
}
MineArea.prototype.MouseOut = function (e) {
    if (this.LastActiveCell != null)
        this.OnMineAreaMouseOut(this.LastActiveCell);
    this.LastActiveCell = null;
}

//CellRender
function CellRender(context, cellSize, cellStyle) {
    this.Context = context;
    this.CellSize = cellSize;
    this.CellStyle = cellStyle;
}

CellRender.prototype.RenderCellBorder = function (x, y) {
    this.Context.lineWidth = this.CellStyle.CellBorderLineWidth;
    this.Context.strokeStyle = this.CellStyle.CellBorderStyle;
    this.Context.strokeRect(x * this.CellSize, y * this.CellSize, this.CellSize, this.CellSize);
}

CellRender.prototype.RenderCellImage = function (image, x, y) {
    this.Context.drawImage(image, x * this.CellSize, y * this.CellSize, this.CellSize, this.CellSize);
    this.RenderCellBorder(x, y);
}

CellRender.prototype.RenderIncorrect = function (x, y) {
    this.Context.strokeStyle = this.CellStyle.IncorrectLineStyle;
    this.Context.lineWidth = this.CellStyle.IncorrectLineWidth;

    this.Context.beginPath();
    this.Context.moveTo(x * this.CellSize, y * this.CellSize);
    this.Context.lineTo(x * this.CellSize + this.CellSize, y * this.CellSize + this.CellSize);
    this.Context.stroke();

    this.Context.beginPath();
    this.Context.moveTo(x * this.CellSize, y * this.CellSize + this.CellSize);
    this.Context.lineTo(x * this.CellSize + this.CellSize, y * this.CellSize);
    this.Context.stroke();
}

CellRender.prototype.RenderNormal = function (x, y) {
    this.RenderCellImage(this.CellStyle.NormalImage, x, y);
}

CellRender.prototype.RenderEmpty = function (x, y) {
    this.Context.fillStyle = this.CellStyle.EmptyFillStyle;
    this.Context.fillRect(x * this.CellSize, y * this.CellSize, this.CellSize, this.CellSize);
    this.RenderCellBorder(x, y);
    this.Context.strokeStyle = this.CellStyle.EmptyShadowStyle;
    this.Context.lineWidth = this.CellStyle.CellBorderLineWidth;
    this.Context.strokeRect(x * this.CellSize + this.CellStyle.CellBorderLineWidth, y * this.CellSize + this.CellStyle.CellBorderLineWidth, this.CellSize - 2 * this.CellStyle.CellBorderLineWidth, this.CellSize - 2 * this.CellStyle.CellBorderLineWidth);
}

CellRender.prototype.RenderFlag = function (x, y) {
    this.RenderCellImage(this.CellStyle.FlagImage, x, y);
}

CellRender.prototype.RenderIncorrectFlag = function (x, y) {
    this.RenderFlag(x, y);
    this.RenderIncorrect(x, y);
}

CellRender.prototype.RenderAsk = function (x, y) {
    this.RenderCellImage(this.CellStyle.AskImage, x, y);
}

CellRender.prototype.RenderMine = function (x, y) {
    this.RenderCellImage(this.CellStyle.MineImage, x, y);
}

CellRender.prototype.RenderIncorrectMine = function (x, y) {
    this.RenderCellImage(this.CellStyle.MineImage, x, y);
    this.RenderIncorrect(x, y);
}

CellRender.prototype.RenderExplodedMine = function (x, y) {
    this.RenderCellImage(this.CellStyle.ExplodedMineImage, x, y);
}

CellRender.prototype.RenderHighlight = function (x, y) {
    this.RenderCellImage(this.CellStyle.HighlightImage, x, y);
}

CellRender.prototype.RenderOne = function (x, y) {
    this.RenderCellImage(this.CellStyle.ImageOne, x, y);
}

CellRender.prototype.RenderTwo = function (x, y) {
    this.RenderCellImage(this.CellStyle.ImageTwo, x, y);
}

CellRender.prototype.RenderThree = function (x, y) {
    this.RenderCellImage(this.CellStyle.ImageThree, x, y);
}

CellRender.prototype.RenderFour = function (x, y) {
    this.RenderCellImage(this.CellStyle.ImageFour, x, y);
}

CellRender.prototype.RenderFive = function (x, y) {
    this.RenderCellImage(this.CellStyle.ImageFive, x, y);
}

CellRender.prototype.RenderSix = function (x, y) {
    this.RenderCellImage(this.CellStyle.ImageSix, x, y);
}

CellRender.prototype.RenderSeven = function (x, y) {
    this.RenderCellImage(this.CellStyle.ImageSeven, x, y);
}

CellRender.prototype.RenderEight = function (x, y) {
    this.RenderCellImage(this.CellStyle.ImageEight, x, y);
}
