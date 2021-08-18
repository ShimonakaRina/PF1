// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require bxslider

jQuery(document).on('turbolinks:load', function(){
  var slider = document.getElementsByClassName('bxslider');
  $('.bxslider').bxSlider({
    auto: true,           // 自動スライド
    speed: 1000,          // スライドするスピード
    moveSlides: 1,        // 移動するスライド数
    pause: 3000,          // 自動スライドの待ち時間
    maxSlides: 1,         // 一度に表示させる最大数
    slideWidth: 500,      // 各スライドの幅
	randomStart: true,    // 最初に表示するスライドをランダムに設定
    autoHover: true       // ホバー時に自動スライドを停止
  });
});

// ページ読み込み完了後一度実行する処理を中に記載する
$(function(){
  //.search-area-formが押されたら実行する
  $('.search-area-form').on('click', function() {
    //押された要素にsearch-area-expansionクラスを付ける
    $(this).addClass("search-area-expansion");
    //.search-formの全ての要素から-noneを取り除く
    $('.search-form').removeClass("d-none");
  });
})

