//  cocoonにて孫までネストしたフォームを作成したい場合にlink_to_add_associationで追加された子フォームの中で一意のIDを振りたい場合に、
//  f.indexがnew_recordの時は対応できないため、固定のID+連番を自動的にIDとして付与するスクリプト
//　この関数を使う場合は追加されるnodeのclassに「child_form」を追加して使用する
//  追加されるnodeの中で動的なIDにしたい文字列を引数に渡す
function cocoonChangeChildTemplateId(id) {
    document.addEventListener('DOMContentLoaded', function () {
        // 監視対象となる要素
        const targetNode = document.body;
        // オブザーバの設定
        const config = { childList: true, subtree: true };
        // コールバック関数
        const callback = function (mutationsList, observer) {
            for (let mutation of mutationsList) {
                if (mutation.type === 'childList' && mutation.addedNodes.length > 0) {
                    for (let node of mutation.addedNodes) {
                        // 追加されたノードが目的の要素か確認
                        if (node.classList && node.classList.contains('child_form')) {
                            updateChildAddLinkIds(id);
                            updateChildDataAttributes(id);
                        }
                    }
                }
            }
        }
        
        // オブザーバインスタンスを作成
        const observer = new MutationObserver(callback);
        
        // 監視開始
        observer.observe(targetNode, config);
    });
    //  IDを付与
    updateChildAddLinkIds(id);
    //  link_to_add_associationのdata-association-insertion-nodeを変更
    updateChildDataAttributes(id);
}

function updateChildDataAttributes(id) {
    const items = document.querySelectorAll(`[data-association-insertion-node^="#${id}"]`);
    
    // 各要素のdata-association-insertion-nodeを連番に設定
    items.forEach((item, index) => {
        item.setAttribute('data-association-insertion-node', `#${id}${index + 1}`);
    });
}

function updateChildAddLinkIds(id) {
    // id="test"を持つすべての要素を取得
    const allItems = document.querySelectorAll(`[id^="${id}"]`);
    const filteredItems = Array.from(allItems).filter(item => {
        const id = item.id;
        const regex = new RegExp(`^${id}(\\d+)?$`);
        return regex.test(id);
    });
    
    // 各要素に連番のIDを設定
    filteredItems.forEach((item, index) => {
        item.id = `${id}${index + 1}`;
    });
}