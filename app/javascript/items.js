document.addEventListener("turbolinks:load"
, function () {
console.log(1)
  // 画像用のinputを生成する関数
  const buildFileField = (num)=> {
    const html = `<div data-index="${num}" class="js-file_group">
                  <input class="js-file" type="file"
                    name="item[item_images_attributes][${num}][src]"
                    id="item_item_images_attributes_${num}_src"><br>
                  </div>`;
    return html;
  }

  const buildImg = (index, url)=> {
    const html = `<div class="image-box">

                    <img data-index="${index}" src="${url}" width="112px" height="112px">
                    
                      <div class="js-remove">削除</div>
                      <div class="js-edit">編集</div>
                      
                  </div>`;
    return html;
  }
  console.log(2)
  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  
  
  console.log(3)
  // 既に使われているindexを除外
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);
  console.log(4)
  $('.hidden-destroy').hide();
  console.log(5)
  $('#image-box').on('change', '.js-file', function(e)  {
    console.log(6)
    const targetIndex = $(this).parent().data('index');
    
    // ファイルのブラウザ上でのURLを取得する
    console.log(7)
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);
    
    // 該当indexを持つimgタグがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {  

      
      //appendではなく、prependで要素を前から表示
      // $('#previews').prepend(buildImg(targetIndex, blobUrl));
      $('.item_image').before(buildImg(targetIndex, blobUrl));
       // 画像投稿枚数10枚まで
      // if($(".js-file_group").length >= 10){
      //   return false;
      // } else {

      // attrを使って画像が投稿される度にlabelのfor属性を変える(0→1→2)
      $('label.item_image').attr("for", `item_item_images_attributes_${targetIndex + 1}_src`);

      // fileIndexの先頭の数字を使ってinputを作る
      $('#image-box').prepend(buildFileField(fileIndex[0]));
      fileIndex.shift();
      console.log(fileIndex);
      
      // 末尾の数に1足した数を追加する
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
      console.log(fileIndex);
      

      // 商品編集
      // lastIndex = $('.js-file_group:last').data('index');
      // fileIndex.push(lastIndex);

      }
    // }

  });

  $('#image-box').on('click', '.js-edit', function() {
    const targetIndex = $(this).prev().prev().data('index');
    $(`#item_item_images_attributes_${targetIndex}_src`).trigger("click");;
  });

  $('#image-box').on('click', '.js-remove', function() {
      // debugger
    const targetIndex = $(this).prev().data('index');
    const inputField = $(`#item_item_images_attributes_${targetIndex}_src`)
    inputField.parent().remove();
    inputField.remove();

    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);
    
    const hiddenCheckEdit = $(`#item_item_images_attributes_${targetIndex}__destroy`);
    if (hiddenCheckEdit) hiddenCheckEdit.prop('checked', true);

    $(this).parent().remove()
    $(`img[data-index="${targetIndex}"]`).remove();
    // 画像入力欄が0個にならないようにしておく
    if ($('.js-file').length == 0) $('#image-box').insertAdjacentHTML(buildFileField(fileIndex[0]));

    let i = 1;
    while (i <= 10) {
      if (fileIndex.includes(i)==false) {
        fileIndex.push(i)
        break;
      }
      i = i + 1;
    }
  });
});