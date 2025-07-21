import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="group-icon"
export default class extends Controller {
  static targets = [
    "input",
    "fileName",
    "iconPreview",
    "deleteBtn",
    "deleteCheckField"
  ]

  static values = {
    iconPresent: Boolean,
    iconName: String
  }


  //初期設定
  connect() {
    if (this.isIconPresent()){
      this.showSelectedFileName(this.iconNameValue)
      this.displayBtn()
    } else {
      this.hiddenBtn()
      this.showSelectedFileName("選択されていません。")
    }
  }


  clickDelete(){
    if (this.iconPresentValue){
      //アイコン設定済みの場合
      this.checkDelete()
    } else {
      this.deleteSelectedFile()
    }
    this.hiddenBtn()
    this.showSelectedFileName("選択されていません。")
  }


  updateFileName() {
    const file = this.inputTarget.files[0]
    if (file){
      this.uncheckDelete()
      this.showSelectedFileName(file.name)
      this.displayBtn()
      return
    }
    if (this.ischeckDelete() || !this.isIconPresent()) {
      this.showSelectedFileName("選択されていません。")
      return
    }
    this.showSelectedFileName(this.iconNameValue)
    this.displayBtn()
  }




  // references..........
  isIconPresent(){
    return this.iconPresentValue
  }

  //削除ボタンの表示
  displayBtn(){
    this.deleteBtnTarget.classList.remove("hidden")
  }
  //削除ボタンの非表示
  hiddenBtn(){
    this.deleteBtnTarget.classList.add("hidden")
  }

  //設定済アイコンの削除パラメータtrue
  checkDelete(){
    this.deleteCheckFieldTarget.checked = true;
  }
  //設定済アイコンの削除パラメータfalse
  uncheckDelete(){
    this.deleteCheckFieldTarget.checked = false;
  }

  ischeckDelete(){
    return this.deleteCheckFieldTarget.checked
  }

  deleteSelectedFile(){
    this.inputTarget.value = ""
  }

  showSelectedFileName(fileName){
    this.fileNameTarget.textContent = fileName
  }

}
