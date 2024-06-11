window.addEventListener("load", () => {
  ActiveStorage.start()
})

const customDirectUploads = (element) => {
  const input = $(element)
  const files = input.prop('files')
  const inputName = input.attr('name')

  console.log(files)
  for(let i = 0; i < files.length; i++) {
    const file = files[i]
    const upload = new ActiveStorage.DirectUpload(file, '/rails/active_storage/direct_uploads')
    upload.create((error, blob) => {
      if (error) {
        console.log("Error");
        console.log(error)
        window.alert('画像アップロードに失敗しました。もう一度お試しください。')
      } else {
        const hiddenField = document.createElement('input')
        hiddenField.setAttribute("type", "hidden")
        hiddenField.setAttribute("value", blob.signed_id)
        hiddenField.name = inputName
        input.before(hiddenField)
        const fileFields = input.siblings('.uploaded-files')
        if (fileFields) {
          const fileLink = document.createElement('a')
          fileLink.href = '/rails/active_storage/blobs/redirect/' + blob.signed_id + '/' + blob.filename
          fileLink.textContent = blob.filename
          fileLink.target = '_blank'
          fileFields.append(fileLink)
        }
      }
    })
  }

  input.val('')
}
