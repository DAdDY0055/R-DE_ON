# README

# R!DE ON

## 概要
自転車を楽しむ人のために、サイクリングコースの情報共有するサイト
## コンセプト
自転車で出かけたいけどどこに行けば良いかわからない、休憩場所は？トイレはどうする？といった不安を解消する
## バージョン
Ruby 2.5.3  
Rails 5.2.1  

## 機能一覧
  [ ] ログイン機能
  [ ] ユーザ登録機能
     [ ] メールアドレス、名前、パスワードは必須
  [ ] パスワード再設定機能
  [ ] スポット一覧表示機能
     [ ] GoogleMapに位置情報を表示
  [ ] スポット登録機能
     [ ] 登録時に住所を入力 or 画像情報を元に位置情報を取得
  [ ] スポット編集機能
  [ ] スポット削除機能
    [ ] スポット編集と削除は投稿者 or 管理人のみ実行可能
  [ ] スポットコメント機能
  [ ] スポットいいね機能
      [ ] スポットへのいいねは1つのスポットに対して1人1回しかできない
      [ ] 自分自身の投稿にはいいねができない
  [ ] スポットお気に入り機能
      [ ] スポットへのお気に入りは1つのスポットに対して1人1回しかできない
　     [ ] 自分自身の投稿はお気に入りができない
　 [ ] 自分自身の投稿にはいいねができない

## カタログ設計
　https://docs.google.com/spreadsheets/d/1zG4kDDiS4ucqqBxrzHuv8KqRa4GX-yvrnfudo1Huook/edit?usp=sharing

## テーブル定義
  https://docs.google.com/spreadsheets/d/15utTC0JKQOG81DPjXzWETL8TmWhE8-igLcQIRanM3Sc/edit?usp=sharing

## 画面遷移図
  https://docs.google.com/spreadsheets/d/1CqLbWLTul6_URZ9hRJTL6ej65HWvGuc4xy0ABAtGXI0/edit?usp=sharing

## 画面ワイヤーフレーム
  https://docs.google.com/spreadsheets/d/1cKK_IiveCLuICk--9rmxJhnSPitq7w6z0Nte2Qdh7Q8/edit?usp=sharing

## 使用予定Gem
　 - carrierwave
　 - mini_magick
　 - devise
　 - geocoder
   - exifr