//StorageInfo
function StorageInfo(gameInfo, currentMine, currentFace) {
    this.GameInfo = gameInfo;
    this.CurrentMine = currentMine;
    this.CurrentFace = currentFace;
}
StorageInfo.prototype.Clone = function () {
    return new StorageInfo(this.GameInfo.Clone(), this.CurrentMine, this.CurrentFace);
}

//GameStorage
function GameStorage(maxSize, storageAreaStyle, storageAreaMouseOverHandler, storageAreaMouseOutHandler, storageAreaMouseUpHandler, maxHandler, saveHandler, deleteHandler) {
    this.MaxSize = maxSize;
    this.StorageAreaStyle = storageAreaStyle;

    this.StorageAreaMouseOverHandler = storageAreaMouseOverHandler;
    this.StorageAreaMouseOutHandler = storageAreaMouseOutHandler;
    this.StorageAreaMouseUpHandler = storageAreaMouseUpHandler;

    this.MaxHandler = maxHandler;
    this.SaveHandler = saveHandler;
    this.DeleteHandler = deleteHandler;

    this.List = new Array();
}
GameStorage.prototype.HandlerIsValidated = function (handler) {
    return !(handler == null || typeof (handler) != "function");
}
GameStorage.prototype.OnMax = function (index) {
    if (this.HandlerIsValidated(this.MaxHandler))
        this.MaxHandler(index);
}
GameStorage.prototype.OnSave = function (index, storageArea) {
    if (this.HandlerIsValidated(this.SaveHandler))
        this.SaveHandler(index, storageArea);
}
GameStorage.prototype.OnDelete = function (index) {
    if (this.HandlerIsValidated(this.DeleteHandler))
        this.DeleteHandler(index);
}
GameStorage.prototype.SaveGame = function (storageInfo) {
    if (this.List.length >= this.MaxSize) {
        this.OnMax(this.List.length);
    }
    else {
        this.List.push(storageInfo.Clone());
        var storageArea = this.CreateOneStorageArea(storageInfo, this.StorageAreaStyle);

        if (this.HandlerIsValidated(this.StorageAreaMouseOverHandler))
            storageArea.addEventListener('mouseover', this.StorageAreaMouseOverHandler, false);
        if (this.HandlerIsValidated(this.StorageAreaMouseOutHandler))
            storageArea.addEventListener('mouseout', this.StorageAreaMouseOutHandler, false);
        if (this.HandlerIsValidated(this.StorageAreaMouseUpHandler))
            storageArea.addEventListener('mouseup', this.StorageAreaMouseUpHandler, false);
        this.OnSave(this.List.Length - 1, storageArea);
    }
}
GameStorage.prototype.DeleteGame = function (index) {
    var storageInfo = this.List[index];
    this.List.splice(index, 1);
    this.OnDelete(index);
}
GameStorage.prototype.GetGame = function (index) {
    return this.List[index];
}

GameStorage.prototype.CreateOneStorageArea = function (storageInfo, storageAreaStyle) {
    var canvas = window.document.createElement("CANVAS");
    var storageCellSize = storageAreaStyle.StorageCellSize;

    canvas.width = storageInfo.GameInfo.MineInfo.X * storageCellSize
    canvas.height = storageInfo.GameInfo.MineInfo.Y * storageCellSize;

    var context = canvas.getContext('2d');
    context.lineWidth = storageAreaStyle.StorageCellBorderLineWidth;
    context.strokeStyle = storageAreaStyle.StorageCellBorderStyle;

    for (var i = 0; i < storageInfo.GameInfo.MineInfo.X; i++) {
        for (var j = 0; j < storageInfo.GameInfo.MineInfo.Y; j++) {
            var x = i * storageCellSize;
            var y = j * storageCellSize;
            switch (storageInfo.GameInfo.MineInfo.Data[i][j].S) {
                case 0:
                    context.fillStyle = storageAreaStyle.SavedCellStyle;
                    break;
                case 1:
                    context.fillStyle = storageAreaStyle.SavedCellFlagStyle;
                    break;
                case 2:
                    context.fillStyle = storageAreaStyle.SavedCellAskStyle;
                    break;
                case 3:
                    if (storageInfo.GameInfo.MineInfo.Data[i][j].N > 0) {
                        switch (storageInfo.GameInfo.MineInfo.Data[i][j].N) {
                            case 1:
                                context.fillStyle = storageAreaStyle.SavedCellOneStyle;
                                break;
                            case 2:
                                context.fillStyle = storageAreaStyle.SavedCellTwoStyle;
                                break;
                            case 3:
                                context.fillStyle = storageAreaStyle.SavedCellThreeStyle;
                                break;
                            case 4:
                                context.fillStyle = storageAreaStyle.SavedCellFourStyle;
                                break;
                            case 5:
                                context.fillStyle = storageAreaStyle.SavedCellFiveStyle;
                                break;
                            case 6:
                                context.fillStyle = storageAreaStyle.SavedCellSixStyle;
                                break;
                            case 7:
                                context.fillStyle = storageAreaStyle.SavedCellSevenStyle;
                                break;
                            case 8:
                                context.fillStyle = storageAreaStyle.SavedCellEightStyle;
                                break;
                            default:
                                context.fillStyle = storageAreaStyle.SavedCellStyle;
                                break;
                        }
                    }
                    else {
                        context.fillStyle = storageAreaStyle.SavedCellEmptyStyle;
                    }
                    break;
                case 4:
                    context.fillStyle = storageAreaStyle.SavedCellMineYesStyle;
                    break;
                case 5:
                    context.fillStyle = storageAreaStyle.SavedCellMineNoStyle;
                    break;
                case 6:
                    context.fillStyle = storageAreaStyle.SavedCellMineExplodedStyle;
                    break;
                case 7:
                    context.fillStyle = storageAreaStyle.SavedCellIncorrectFlagStyle;
                    break;
                default:
                    context.fillStyle = storageAreaStyle.SavedCellStyle;
                    break;
            }
            context.fillRect(x, y, storageCellSize, storageCellSize);
            context.strokeRect(x, y, storageCellSize, storageCellSize);
        }
    }
    return canvas;
}
