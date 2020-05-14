import NimQml
import Tables
import chat/core as chat

type
  RoleNames {.pure.} = enum
    Name = UserRole + 1,

QtObject:
  type
    ChatsLogModel* = ref object of QAbstractListModel
      names*: seq[string]
      chatsResult*: string

  proc delete(self: ChatsLogModel) =
    self.QAbstractListModel.delete

  proc setup(self: ChatsLogModel) =
    self.QAbstractListModel.setup

  proc newChatsLogModel*(): ChatsLogModel =
    new(result, delete)
    result.names = @[]
    result.chatsResult = "default"
    result.setup

  # proc addNameTolist*(self: ChatsLogModel, chatId: string) {.slot, signal.} =
  proc addNameTolist*(self: ChatsLogModel, chatId: string) {.slot.} =
    # chat.join(chatId)
    self.beginInsertRows(newQModelIndex(), self.names.len, self.names.len)
    self.names.add(chatId)
    self.endInsertRows()

  proc chatResult*(self: ChatsLogModel): string {.slot.} =
    self.addNameTolist("hi again")
    echo "------------"
    echo self.chatsResult
    echo "------------"
    # self.addNameTolist(self.chatsResult)
    echo "chatResultCalled!"
    result = self.chatsResult
    # result = self.callResult

  proc chatResultChanged*(self: ChatsLogModel, callResult: string) {.signal.}

  proc setChatResult*(self: ChatsLogModel, callResult: string) {.slot.} =
    echo "new chat result!"
    echo callResult
    # if self.callResult == callResult: return
    self.chatsResult = callResult
    echo "============="
    echo self.chatsResult
    echo "============="
    self.chatResultChanged(callResult)
    # self.addNameTolist("hi again")

  proc `chatResult=`*(self: ChatsLogModel, callResult: string) = self.setChatResult(callResult)

  QtProperty[string] chatsResult:
    read = chatResult
    write = setChatResult
    notify = chatResultChanged
  
  method rowCount(self: ChatsLogModel, index: QModelIndex = nil): int =
    return self.names.len

  method data(self: ChatsLogModel, index: QModelIndex, role: int): QVariant =
    if not index.isValid:
      return
    if index.row < 0 or index.row >= self.names.len:
      return
    return newQVariant(self.names[index.row])

  method roleNames(self: ChatsLogModel): Table[int, string] =
    { RoleNames.Name.int:"username"}.toTable
