import NimQml
import libstatus

QtObject:
  type 
    LibStatusQml* = ref object of QObject


  # ¯\_(ツ)_/¯ dunno what is this
  proc setup(self: LibStatusQml) =
    self.QObject.setup
  
   # ¯\_(ツ)_/¯ seems to be a method for garbage collection
  proc delete*(self: LibStatusQml) =
    self.QObject.delete

  # Constructor
  proc newLibStatusQml*(): LibStatusQml =
    new(result, delete)
    result.setup

  proc hashMessage*(self: LibStatusQml, p0: string): string =
    return $libstatus.hashMessage(p0)

  proc initKeystore*(self: LibStatusQml, keydir: string): string =
    return $libstatus.initKeystore(keydir)

  # proc openAccounts*(datadir: cstring): cstring {.importc: "OpenAccounts".}

  # proc multiAccountGenerateAndDeriveAddresses*(paramsJSON: cstring): cstring {.importc: "MultiAccountGenerateAndDeriveAddresses".}

  # proc multiAccountStoreDerivedAccounts*(paramsJSON: cstring): cstring {.importc: "MultiAccountStoreDerivedAccounts".}

  # proc saveAccountAndLogin*(accountData: cstring, password: cstring, settingsJSON: cstring, configJSON: cstring, subaccountData: cstring): cstring {.importc: "SaveAccountAndLogin".}

  # proc callRPC*(inputJSON: cstring): cstring {.importc: "CallRPC".}

  # proc callPrivateRPC*(inputJSON: cstring): cstring {.importc: "CallPrivateRPC".}

  # proc addPeer*(peer: cstring): cstring {.importc: "AddPeer".}

  # proc setSignalEventCallback*(callback: SignalCallback) {.importc: "SetSignalEventCallback".}