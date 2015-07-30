% OSS普及協議会Ruby勉強会1
% ka ([kaosfield](http://www.kaosfield.net))
% 2015-07-18

# はじめに

このスライドは公開されています

このスライドのリポジトリは[https://github.com/kaosf/20150731-oss-ruby](https://github.com/kaosf/20150731-oss-ruby)にあります

間違いなどを見つけた場合は

<ul>
<li>メールで連絡</li>
<li>Issueで報告</li>
<li>Pull Requestで修正案を提出</li>
</ul>

などしていただけるとありがたいです (※下に行くほど嬉しいです)

# 今回の進め方

Rubyを試せる環境を手元で構築してもらいます

講師がスライドを進めながら都度ライブコーディングを行います

それを見ているだけでもRubyの雰囲気やRuby独特の感覚は掴めると思います

余力のある方は手元に構築した環境で自分自身の手でも試してみましょう

# Rubyをインストール (Windows)

Windows上で直にRubyを動かす方法を今回は採りません

VirtualBoxとVagrantとイメージのファイルを配ります

そこでLinux(CentOS)を動かしRuby環境を実現します

仮想マシンとそこに接続する環境が出来上がった人は

```bash
ruby -v
```

と打ってエラーが出ずにRubyのバージョンが表示されることを確認しましょう

# Rubyをインストール (Ubuntu)

```bash
sudo apt-get install git curl build-essential \
  zlib1g-dev libssl-dev libreadline6-dev libffi-dev

git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $HOME/.profile
echo 'eval "$(rbenv init -)"' >> $HOME/.profile
exec $SHELL -l

mkdir -p $HOME/.rbenv/plugins
git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build

rbenv install 2.2.2
rbenv global 2.2.2
rbenv rehash
```

`~/.profile` の代わりに `~/.zshenv` を使うなどは適宜読み替えて下さい

`~/.profile` で上手く行かない場合は `~/.bash_profile` や `~/.bashrc` などを試みて下さい

# Rubyをインストール (CentOS)

```bash
sudo yum install openssl-devel zlib-devel readline-devel
```

後はUbuntuでやったのと同じです

# Rubyをインストール (Mac)

まずHomebrewというものをインストールします

[Homebrew — The missing package manager for OS X](http://brew.sh/)

これにより `brew` コマンドが使えるようになったら以下でOKです

```bash
brew update
brew install rbenv
brew install ruby-build

echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile

rbenv install 2.2.2
rbenv global 2.2.2
rbenv rehash
```

# rbenvとは

<span style="color:red">R</span>u<span style="color:red">B</span>y <span style="color:red">ENV</span>ironment という意味(だと思います)(※どこにも明言はされていない)


Rubyを複数のバージョン同時にインストールしてそれの切り替えなんかを面倒見てくれるものです

# rbenvの必要性

Rubyはバージョンアップのサイクルが恐ろしく速いです

新しいバージョンをどんどん試して行きたいというか  
試していかないと気付いた時には凄く前のバージョンで留まってる  
なんてことにごく普通になりがちです

しかし古いバージョンで動いてるものを動かなくさせてしまうかもしれない

色んなバージョンのRuby (jruby も mruby もある)をインストールして使い分けられます

インストール可能な一覧は以下のコマンドで確認出来ます

```bash
rbenv install -l
```

# rvmを使ってのインストール

似たツールに rvm というものもあります

Mac でも brew で rvm がインストール出来ない(無い)ので以下の方法でインストールします

```bash
curl -L https://get.rvm.io | bash -s stable --autolibs=enabled
rvm install 2.2.2
```

最新版Rubyをこの後使うので以下でも良いです

```bash
curl -L https://get.rvm.io | bash -s stable --autolibs=enabled --ruby
```

# (余談)rvmのアンインストール

```bash
rvm seppuku
```

# Hello world

hello.rbというファイルに以下のように書く

```rb
puts 'Hello world'
```

コンソールから以下のコマンドを実行

```bash
ruby hello.rb
```

これでHello worldが出来た

# 今日の最大の目的は達成しました

- 拍手！

# Ruby自体の基礎知識

入門的なことは説明しない

※既に世の中にたくさんの書籍が出ているのでそれを使って自分のペースで手習いすると良い

※もし分からないことが出てきたら是非tokushima.rbにお越し下さい(宣伝)

# ifは文ではなく式である

式であるので値を持つ

```ruby
x = if true
  1
else
  2
end

p x #=> 1
```

```ruby
y = if false
  1
else
  2
end

p y #=> 2
```

# case式

同様にcaseも式である

```ruby
x = 1

y = case x
when 1
  10
when 2
  100
else
  0
end

p y #=> 10
```

# メソッドにreturnは書かない

メソッドで最後に評価された式の値がメソッドの戻り値になる

```ruby
def m
  1 + 1 # 戻り値には関係しない
  1
end

p m #=> 1
```

# メソッドにreturnは書かない

```ruby
def m(x)
  if x > 0
    'pos'
  elsif x < 0
    'neg'
  else
    'zero'
  end
end

p m(1) #=> "pos"
p m(-1) #=> "neg"
p m(0) #=> "zero"
```

# returnを書くのはどういうときか

途中でメソッドを終わりたい場合

```ruby
def average(a)
  return nil if a.empty?

  sum = 0.0
  a.each { |i| sum += i }
  sum / a.size
end

p average([1, 2, 3]) #=> 2.0
p average([]) #=> nil
```

# メソッドの設計も疑った方が良い

```ruby
def average(a)
  sum = 0.0
  a.each { |i| sum += i }
  sum / a.size
end

a = [1, 2, 3]

if a.empty?
  # 平均値が計算出来ない場合の処理をその都度考えられる
  # 0.0を返すべきなのかnilを返すべきなのか
else
  average a
end
```

こうした方が良いということを示唆しているかもしれない

# classとmodule

インスタンスメソッドの定義とクラスメソッドの定義

```ruby
class C
  def m
    puts 'C#m'
  end

  def self.cm
    puts 'C.cm'
  end
end

C.new.m #=> 'C#m'
C.cm #=> 'C.cm'
```

これ以外にもやり方はある

# classとmodule

```ruby
module M
  def m
    puts 'M m'
  end
end



include M

m #=> 'M m'
```

moduleはincludeするとその場に展開されるイメージ

# classとmodule

```ruby
#module M
#  def m
#    puts 'M m'
#  end
#end

def m
  puts 'M m'
end

m #=> 'M m'
```

moduleはincludeするとその場に展開されるイメージ

# メソッドの記法について

インスタンスメソッドは # を用いて

```
C#m
```

クラスメソッドは . を用いて

```
C.cm
```

のように表記されることがあるのでそれに則る

※インスタンスメソッドの方はそう呼べるわけではないので注意

# モジュールはクラスに組み込まれる

includeの場合

```ruby
module M
  def m
    puts 'M m'
  end
end

class C
  include M
end

C.new.m #=> 'M m'
```

# モジュールはクラスに組み込まれる

extendの場合

```ruby
module M
  def m
    puts 'M m'
  end
end

class C
  extend M
end

C.m #=> 'M m'
```

#

おわかりいただけただろうか

#

includeはその場に展開されるイメージを思い出すと良い

```ruby
#module M
#  def m
#    puts 'M m'
#  end
#end

class C
  #include M
  def m
    puts 'M m'
  end
end

C.new.m #=> 'M m'
```

# moduleは名前空間としても使える

```ruby
module M1
  class C
    def m
      puts 'method m of C of M1'
    end
  end
end

module M2
  class C
    def m
      puts 'method m of C of M2'
    end
  end
end

M1::C.new.m #=> method m of C of M1
M2::C.new.m #=> method m of C of M2
```

同じ名前のクラスCだが名前空間で区別される

# requireの使い方

実用していると欲しくなるのがファイル分割

`13-lib.rb` を以下のように用意する

```ruby
def f(x)
  x + 1
end
```

`13.rb` を以下のように用意する

```ruby
require './13-lib'

p f(2) #=> 3
```

# {...} do...end Proc proc lambdaとは何か

# {...} do...end は同じ

```ruby
instance.method { do_something }
```

```ruby
instance.method do
  do_something
end
```

複数行の際は do...end が良い

# Proc proc lambda

それぞれ無名関数に関連するものである

`{...}` もしくは `do...end` はメソッドの最後の引数と考える

引数で渡されるのはオブジェクトであり，そのクラスが `Proc` である

### 今回は説明しないこと

`Proc.new`や`proc`を使ってブロックを作成しておくことが出来る

`lambda`あるいは同等の`->`というものを使って無名関数を作ることも出来る

`lambda`で作った方は引数の数のチェックがあるなど若干違いがある

# ブロックを受け取ったところを見てみる

```ruby
# x は普通の引数
# &のついた最後の引数 block が do ... end に書いた「処理そのもの」
def f(x, &block)
  puts x
  puts block.nil? # blockがあるかどうかだけ確認している
end

f 1 do
  call_illegal_method # どうせ呼ばれないので何をしても良い
end
#=>
# 1
# false

f 2
#=>
# 2
# true
```

# ブロックを受け取ったところを見てみる

```ruby
def f(x, &block)
  puts block.class # blockのクラスはProcである
end

f 1 do
  call_illegal_method
end
#=> Proc
```

# ブロックを呼んでみる

```ruby
def f(&block)
  puts 'before call'
  block.call
  puts 'after call'
end

f do
  puts 'in the block'
end
#=>
# before call
# in the block
# after call
```

# ブロックを呼ぶ方法3種類

<ul>
<li>`call`メソッドを呼ぶ</li>
<li>`[]`メソッドを呼ぶ</li>
<li>`yield`</li>
</ul>

```ruby
def f(&block)
  block.call
  block[]
  yield
end

f do
  puts 'in the block'
end
#=>
# in the block
# in the block
# in the block
```

# &block block_given? yieldとは何か

ブロックを引数で受け取るには最後の引数名に `&` をつければ良い

ブロックを受け取ることになっていないメソッドにもブロックは渡せる

```ruby
def f
  puts 'f'
end

f do
  puts 'in the block'
end
#=> f
```

何も起こらない

# &block block_given? yieldとは何か

さきほどはブロックを受け取ったかどうかを`.nil?`で判定した

専用の`block_given?`というメソッドがある

```ruby
def f
  puts block_given?
end

f { call_illegal_method } #=> true
f                         #=> false
```

# &block block_given? yieldとは何か

どうせブロックは一つしか渡せない

なら受け取ったブロックの呼び出しは`yield`と書くだけにすればいいんじゃないか

```ruby
def f
  puts 'f'
  yield
end

f do
  puts 'in the block'
end
#=>
#  f
#  in the block
```

# &block block_given? yieldとは何か

ブロックを受け取っていないのに`yield`を呼んでしまうとエラー

```ruby
def f
  yield
end

f # エラーが発生する
```

なので`block_given?`が役立つ

```ruby
def f
  yield if block_given?
end

f # 何も起こらない(yieldしないのでエラーも起こらない)

f { puts 'in the block' } #=> in the block
```

#

```ruby
yield if block_given?
```

> yield if block given

割と自然な英語で読める

# method_missingの紹介

```ruby
class C
end

C.new.m 1, 2
```

唐突に存在しないメソッドを呼んでみる

当然エラー

# method_missingの紹介

```ruby
class C
  def method_missing(name, *args)
    puts "#{name} called"
    puts args
  end
end

C.new.m 1, 2
#=>
# m called
# 1
# 2

C.new.fooooo #=> fooooo called
```

エラーが発生しないどころかどうやってメソッドが呼ばれたのかの情報が伝わる

#

濫用は非常に危険であるが上手く使えば有用なこともある

例えばfactory_girlというライブラリを見てみると良い

<ul>
<li>
  [thoughtbot/factory_girl](https://github.com/thoughtbot/factory_girl)
</li>
<li>
  [factory_girl/GETTING_STARTED.md at master · thoughtbot/factory_girl](https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md)
</li>
</ul>

# map/collect reduce/inject select

関数型プログラミング的な書き換え

# map/collect reduce/inject select

C言語やJava 7までしか触ったことの無い人(昔の私)の発想

「なんでforループの話が出てこないのだろう」

# map/collect reduce/inject select

アルゴリズムの研究者ならともかくループを直に自分で書く必要は今やほとんど無い

# map/collect reduce/inject select

ありがちなコード

例題: 配列の奇数だけを10倍して総和を求めよ

```ruby
a = [1, 2, 3, 4, 5]

s = 0
for i in a do
  if i % 2 != 0
    s += i * 10
  end
end
p s #=> 90
```

# map/collect reduce/inject select

Rubyで出来る別解

例題: 配列の奇数だけを10倍して総和を求めよ

```ruby
a = [1, 2, 3, 4, 5]

p a.select { |e| e % 2 != 0 }.map { |e| e * 10 }.reduce(0) { |a, e| a + e }

# odd? というメソッドと symbol to_proc と reduce の特性が理解出来ていれば以下でも
p a.select(&:odd?).map { |e| e * 10 }.reduce(&:+)
```

# map/collect

どちらも同じメソッドである

配列(正確にはEnumerableをincludeしたオブジェクト)の全要素に  
与えられたブロックの処理を適用した新たな配列を返す

```ruby
p [1, 2, 3].map { |e| e * 2 } #=> [2, 4, 6]

p ['1', '2', '3'].collect { |e| e.to_i } #=> [1, 2, 3]
```

# reduce/inject

どちらも同じメソッドである

```ruby
p [1, 2, 3].reduce(0) { |a, e| a + e } #=> 6

p ['a', 'b', 'c'].inject('') { |a, e| e + a } #=> "cba"
```

# reduce/injectの動作説明

メソッドの引数を初期値として  
配列(正確には(以下略))の全要素に対して  
ブロックの第一引数が初期値に  
第二引数が各要素になりながら  
戻り値を次のイテレーションの第一引数にし  
ループする  

最終的な戻り値は最後のブロックの戻り値

(※後で詳しく説明します)

(※kamiyama.rbでの発表スライドより抜粋)


# select

配列(正確(略))の全要素に対し  
与えられたブロックの結果が`true`になったものだけを残した新しい配列を返す

```ruby
p [1, 2, 3, 4, 5].select { |e| e.odd? && e >= 3 } #=> [3, 5]
```

# reduce/injectをコードで説明

```ruby
[1, 2, 3].reduce(0) { |a, e| a + e }
```

まず `0` がブロックの `a` に  
`1` が `e` に渡る

`a + e` は `0 + 1` なのでブロックの戻り値は `1`

それが次の `a` になる

# reduce/injectをコードで説明

つまり

```ruby
[1, 2, 3].reduce(0) { |a, e| a + e }
```

が

```ruby
[2, 3].reduce(1) { |a, e| a + e }
```

という状態になる

# reduce/injectをコードで説明

繰り返すと

```ruby
[1, 2, 3].reduce(0) { |a, e| a + e }
[2, 3].reduce(1) { |a, e| a + e }
[3].reduce(3) { |a, e| a + e }
```

そして最後の `a + e` が `6` になりそれが結果になる

# reduce/injectをコードで説明

一つの式で表現

```ruby
(((0 + 1) + 2) + 3)
```

これが計算されるわけである

これは所謂 `foldl` である

# reduce/injectをコードで説明

要素が空の時

```ruby
[].reduce(10) { |a, e| a + e } #=> 10
```

初期値がそのまま返る

#

前のページで「最後のブロックの戻り値が結果になる」と言ったな

あれは嘘だ


# reduce/injectをコードで説明

正しい繰り返しの形

```ruby
[1, 2, 3].reduce(0) { |a, e| a + e }
[2, 3].reduce(1) { |a, e| a + e }
[3].reduce(3) { |a, e| a + e }
[].reduce(6) { |a, e| a + e } #=> 6
```

# reduce/injectをコードで説明

メソッドに初期値渡さない場合は例外的にリストの第一要素が初期値になる

```ruby
[1, 2, 3].reduce { |a, e| a + e }
[2, 3].reduce(1) { |a, e| a + e }
[3].reduce(3) { |a, e| a + e }
[].reduce(6) { |a, e| a + e } #=> 6
```

# gemとBundler

Rubyではライブラリがgemという単位で管理されている

cpanとかpipみたいなものと言えば分かる人は分かる？

# gem install

インストールするコマンドは以下の通り

```sh
gem install rubicure
```

これでRuby内で

```ruby
require 'rubicure'
```

が出来るようになる

# gem install --no-ri --no-rdoc

普通に`gem install`するとドキュメントの生成が発生する

大きなライブラリになるとその時間がバカにならない

以下のオプションでスキップさせられる

```sh
gem install rubicure --no-ri --no-rdoc
```

ホームディレクトリに`.gemrc`というファイルを用意して

```
install: --no-document
update: --no-document
```

と書いておけばオプション指定が不要になる

# --no-riと--no-rdocをデフォルトに

ちなみに

大体皆Webブラウザでドキュメント見るでしょ？これをデフォルトにしようよ

…とはDHH談

# Bundler

大抵は複数のgemを使って何かを開発するのだが毎回`gem install ...`を  
開発者や運用者全員に漏れ無く伝えるのは実質無理

gemを管理してくれるgemが存在する

それがBundler

```sh
gem install bundler
```

でインストール出来る

# Gemfile

まずGemfileというものを用意する(ファイル名`Gemfile`)

```ruby
source 'https://rubygems.org'

gem 'rubicure', '0.2.6'
```

`gem 'gemname', 'version'`という形式で使うgemを列挙する

# bundleコマンド

Gemfileが用意出来たら

```sh
bundle install
```

というコマンドを実行する

# Gemfile.lock

`bundle install`実行後にGemfile.lockというファイルが出来る

これが保持されている限り皆`bundle install`をすれば同じgemを指定したバージョンで使える

# Gemfileのバージョン指定

```ruby
gem 'libname', '1.0.0'    # 固定

gem 'libname', '>= 1.0.0' # 1.0.0以上
                          # OK: 1.0.1, 1.1.0, 2.0.0
                          # NO: 0.9.9

gem 'libname', '~> 1.0.2' # 1.0.2以上の1.0.xを許可
                          # OK: 1.0.2, 1.0.9, 1.0.99
                          # NO: 1.0.0, 1.0.1, 1.1.0, 2.0.0

gem 'libname', '~> 1.3'   # 1.3以上の1.x.yを許可
                          # OK: 1.3.0, 1.3.1, 1.4.0, 1.9.1
                          # NO: 1.2.99, 2.0.0
```

# gemを皆が投稿する場所 rubygems.org

[RubyGems.org | your community gem host](https://rubygems.org/)

gemの大体はソースコードがGitHub上に公開されている

例

- [rails/rails](https://github.com/rails/rails)
- [sue445/rubicure](https://github.com/sue445/rubicure)
- [igrep/crispy](https://github.com/igrep/crispy)
- [kaosf/apns-s3](https://github.com/kaosf/apns-s3)

# 試しにRailsをインストール

```sh
gem install --no-ri --no-rdoc rails -v 4.2.3
```

※ちょっと時間掛かると思うので残り時間余裕あったらやって下さい

# キーワード付き引数

```ruby
def f(x: nil, y: nil, z: 3)
  p x + y + z
end

f x: 10, y: 100 #=> 113
f y: 100, x: 10 #=> 113
f z: 1000, y: 100, x: 10 #=> 1110
```

「引数の順番」というあの煩わしさを引数名を明示して解消

引数名を明示することにより呼び出し側も意図を明確に出来る

Ruby 2.0.0から使える

# itselfメソッド

自分自身を返すメソッド

```ruby
p 1.itself #=> 1
p "a".itself #=> "a"
p nil.itself #=> nil

p [1, 2, 3].map { |e| e.itself } #=> [1, 2, 3]
```

数学の言葉で言うと「恒等写像」「恒等関数」

Ruby 2.2.0から使える

#

おわり
