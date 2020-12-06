$(function(){
  function appendOption(category){
    var html = `<option value="${category.id}">${category.name}</option>`;
    console.log('change3');
    return html
  }
  function appendChildrenBox(insertHTML){
    console.log('change4');
    var childSelectHtml = "";
    childSelectHtml = `<div class="child_" id="children_wrapper">
                        <select id="child__category" name="item[category_id]" class="serect_field">
                          <option value="">選択してください</option>
                          ${insertHTML}
                        </select>
                      </div>`;
    $('.append__category').append(childSelectHtml);
    console.log('change5');
  }
  function appendGrandchildrenBox(insertHTML){
    var grandchildSelectHtml = "";
    grandchildSelectHtml = `<div class="child_" id="grandchildren_wrapper">
                              <select id="grandchild__category" name="item[category_id]" class="serect_field">
                                <option value="">選択してください</option>
                                ${insertHTML}
                                </select>
                            </div>`;
    $('.append__category').append(grandchildSelectHtml);
    
  }

  $('#item_category_id').on('change',function(){
    var parentId = document.getElementById('item_category_id').value;
    if (parentId != ""){
      $.ajax({
        url: '/items/get_category_children/',
        type: 'GET',
        data: { parent_id: parentId },
        dataType: 'json'
      })
      .done(function(children){
        console.log(children)
        $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove();
        $('#item_category_id2').remove();
        $('#item_category_id3').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        console.log(insertHTML)
        appendChildrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children_wrapper').remove();
      $('#grandchildren_wrapper').remove();
      $('#item_category_id2').remove();
      $('#item_category_id3').remove();
    }
  });
  $('.append__category').on('change','#child__category',function(){
    var childId = document.getElementById('child__category').value;
    if(childId != "" && childId != 46 && childId != 74 && childId != 134 && childId != 142 && childId != 147 && childId != 150 && childId != 158){
      $.ajax({
        url: '/items/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        $('#grandchildren_wrapper').remove();
        var insertHTML = '';
        grandchildren.forEach(function(grandchild){
          insertHTML += appendOption(grandchild);
        });
        appendGrandchildrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchildren_wrapper').remove();
    }
  })
});