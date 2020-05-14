import NimQml
import json
import status/accounts

# Probably all QT classes will look like this:
QtObject:
  type Onboarding* = ref object of QObject
    m_generatedAddresses: string

  # ¯\_(ツ)_/¯ dunno what is this
  proc setup(self: Onboarding) =
    self.QObject.setup

  # ¯\_(ツ)_/¯ seems to be a method for garbage collection
  proc delete*(self: Onboarding) =
    self.QObject.delete

  # Constructor
  proc newOnboarding*(): Onboarding =
    new(result, delete)
    result.setup()

  # Read more about slots and signals here: https://doc.qt.io/qt-5/signalsandslots.html




  # Accesors
  proc getGeneratedAddresses*(self: Onboarding): string {.slot.} =
    result = self.m_generatedAddresses

  proc generatedAddressesChanged*(self: Onboarding,
      generatedAddresses: string) {.signal.}

  proc setGeneratedAddresses*(self: Onboarding, generatedAddresses: string) {.slot.} =
    if self.m_generatedAddresses == generatedAddresses:
      return
    self.m_generatedAddresses = generatedAddresses
    self.generatedAddressesChanged(generatedAddresses)

  QtProperty[string]generatedAddresses:
    read = getGeneratedAddresses
    write = setGeneratedAddresses
    notify = generatedAddressesChanged

  # QML functions
  proc generateAddresses*(self: Onboarding) {.slot.} =
    self.setGeneratedAddresses(generateAddresses())
    echo "Done!: ", self.m_generatedAddresses

  proc generateAddresses1*(self: Onboarding) {.slot.} =
    let genAddrs = generateAddresses()
    self.setGeneratedAddresses(genAddrs)
    echo "Generated addresses: ", genAddrs

  # This class has the metaObject property available which lets
  # access all the QProperties which are stored as QVariants
