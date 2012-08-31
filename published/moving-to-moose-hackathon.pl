use Sartak::Blog;

BEGIN { print "title: Mooseを利用するに変えるハッカソン\nbasename: moving-to-moose-hackathon\ndate: 2012-08-31\n" }

p { "Oslo.pmが「[Moving to Moose Hackathon](http://act.yapc.eu/mtmh2012/)(Mooseを利用するに変えるハッカソン)」という会議をノルウェーのプレーケストーレンにある山小屋で開催しました。私は参加したいでしたが、招待頂きました。Oslo.pm、どうもありがとうございます！" };
p { "会議のテーマは二つありました。1つは[RDF](http://act.yapc.eu/mtmh2012/sponsors.html#perlrdf)に興味あるコミュニティが、Mooseを利用するにモジュールを変えるつもりでした。あと1つは、[p5mop](http://act.yapc.eu/mtmh2012/sponsors.html#p5mop)を屈強化して、もう少しperl自体に追加できる状態に準備する予定たちました。" };

h3 { "Day -3 (YAPC::EUの日)" };
p { "ドイツのフランクフルトで開催されたYAPC::EUに参加できました。初めてYAPC::EUだったし、イギリス以外ヨーロッパに行ったことがなかったから、とても嬉しいでした。YAPCで「[Mooseロール利用パターン](http://sartak.org/talks/yapc-eu-2012/role-usage-patterns/)」というトークをやっていきました。今回のトークは、全ての前回よりよくできたな！と私は思います。きっと来年のYAPC::Asiaに行くことがてきるので、たぶん日本語版を話そうとします。今年来られないのはすみません！" };

a {
    href is "http://www.flickr.com/photos/sartak/7838221830";
    image "moving-to-moose-hackathon/yapc-audience.jpg";
};


h3 { "Day 0 (旅の日)" };
p { "フランクフルトからスタヴァンゲルに飛んで行きました。ホテルからフランクフルト空港に、そして飛行機に通った道が分かりにくいと思いました。Hauptbahnhof(中央というか駅)で乗り換えの標識がちょっと読めませんでした。ドイツ語は全然分からないのでした。しかも、空港のゲートを越えた後、バス(!)で飛行機に運ばされまして、道路から階段で直接に乗りました。ビックリした！" };

a {
    href is "http://www.flickr.com/photos/sartak/7880429950";
    image "moving-to-moose-hackathon/flight-in.jpg";
};

a {
    href is "http://www.flickr.com/photos/sartak/7880429316";
    image "moving-to-moose-hackathon/oslo-bus.jpg";
};

p { "結局、プレーケストーレンの山小屋に無事に到着しました。" };

a {
    href is "http://www.flickr.com/photos/sartak/7880431538";
    image "moving-to-moose-hackathon/lodge-lake.jpg";
};

a {
    href is "http://www.flickr.com/photos/sartak/7880431082";
    image "moving-to-moose-hackathon/lodge-interior.jpg";
};

p { "参加者の皆さんが、自己紹介したり、喋ったり、一緒に夕食を食べました。p5mopに興味ある参加者が「基本的に、どうやってroleという概念はp5mopの仕組みに合う？」というを夜中すぎまで論じました。" };
p { "[\@robinsmidsrod](http://twitter.com/robinsmidsrod)さんが「日本語で入力する方法を説明しませんか？」と聞いて、私はもちろん嬉しくなりました ;) その後、XPathとか[XML::Rabbit]とか[Unicode CLDR](http://ja.wikipedia.org/wiki/Common_Locale_Data_Repository)とかとかについて喋りました。" };

h3 { "Day 1 (登山の日)" };
p { "早起きして、プレーケストーレンという有名な崖にハイキングしました。眺めはとっっってもきれいでした！！！" };
p { "旅立ちは10時から16時までかかりました。たいへん疲れました。（四日後でもまだ足が痛い！）" };

a {
    href is "http://www.flickr.com/photos/sartak/7880432218";
    image "moving-to-moose-hackathon/picnic.jpg";
};

a {
    href is "http://www.flickr.com/photos/sartak/7880432884";
    image "moving-to-moose-hackathon/rocky-forest.jpg";
};

a {
    href is "http://www.flickr.com/photos/sartak/7880376022";
    image "moving-to-moose-hackathon/wave-of-trees.jpg";
};

a {
    href is "http://www.flickr.com/photos/sartak/7880377090";
    image "moving-to-moose-hackathon/focused-cliff.jpg";
};

a {
    href is "http://www.flickr.com/photos/sartak/7880435618";
    image "moving-to-moose-hackathon/pulpit-rock.jpg";
};

a {
    href is "http://www.flickr.com/photos/sartak/7880377758";
    image "moving-to-moose-hackathon/topdown-cliff.jpg";
};


p { "その後で、[Fluxx](http://ja.wikipedia.org/wiki/フラックス_(ゲーム))(zombie版とcthulhu版組み合わせられた)というカードゲームをやりました。計画者はプログラマーですから、法則が面白い。しかもルールが進化することまであります。" };

a {
    href is "http://www.flickr.com/photos/sartak/7880437426";
    image "moving-to-moose-hackathon/stevan-peek.jpg";
};

a {
    href is "http://www.flickr.com/photos/sartak/7880438210";
    image "moving-to-moose-hackathon/fluxx-rules.jpg";
};

a {
    href is "http://www.flickr.com/photos/sartak/7880438674";
    image "moving-to-moose-hackathon/pro-perigrin.jpg";
};

h3 { "Day 2 (ハッカソンの一日目)" };
p { "朝食から昼食まで私が「Mooseロール利用パターン」というトーク拡張版を話してあげました。昼食の後で、[\@pmichaud](http://twitter.com/pmichaud)さんが[NQP言語](http://pmichaud.com/2012/pres/mtmh2012-nqp/slides/start.html)について解説しました。プログラミング言語が作りたい方は、NQPを使うことで、きっととても早く計画できると思います。" };
p { "[\@perlyarg](http://twitter.com/perlyarg)さんとMooseのロールテストをp5mopに変更して始まりました。p5mopではロール合成は不完全ですから、そのテストは便利だと思います。" };
p { "最初のp5mopの拡張として[mopx::instance::tracking](https://github.com/stevan/p5-mop/commit/04997c0c93c7)は、私が書いたことができました。Moose版よりも簡単でした。p5mopのClassというメタクラスをサブクラスして、create_instanceというメソッドにオブジェクトを見逃さない挙動を追加されます。" };
p { "夕飯の後で、昨日の旅だし、朝のトークをしたから、たいへん疲れました。で、私がやったことは、Fluxxだけでした。" };

a {
    href is "http://www.flickr.com/photos/sartak/7880533504";
    image "moving-to-moose-hackathon/artsy-stevan.jpg";
};

a {
    href is "http://www.flickr.com/photos/sartak/7879978022";
    image "moving-to-moose-hackathon/perigrin-workstation.jpg";
};

h3 { "Day 3 (ハッカソンの二日目)" };
p { "先日書いたDTraceプローブをPerlに追加する[パッチ](https://rt.perl.org/rt3/Ticket/Display.html?id=114638)をやっと送りました。p5pが受け入れたので、5.18からop-entry、loading-file、loaded-fileというプローブを使うようになります。" };
p { "[\@RubenVerborgh](http://twitter.com/RubenVerborgh)さんが「正規表現を使いこなす教師いますかー！」と聞いて、「私が手伝ってみてあげましょう」と私は答えました。問題は、テストが9秒以上で実行するので、ちょっと遅すぎました。役800回呼び出したregcomp(正規表現をコンパイルする関数)というopcodeに2秒以上部分があることを[Devel::NYTProf]で見つけました。でも、ちゃんと`qr//`を使ったので、regcompがほとんど呼ばないはずだと思いました。残念ですがDevel::NYTProfがopcode内に見ることができませんが、DTraceは各C関数でも見られます。そして私がperl providerのsub-entryとsub-returnというプローブをトレースして、pid providerのC関数のentryとreturnで、遅いマッチだけ内regcompをトレースしました。発見として、700部分のregcompは速いですけど、あと100部分のregcompはその速いregcompより100x以上遅い。なに。。。？後程、遅すぎた正規表現は記録括弧がありまして、その括弧を`(?:...)`に変更することで、とてみ速くなったことができました！実行は9秒から2秒まで減りました。" };
p { "もう一つ問題に手伝ってあげました。AUTOLOADを使っているモジュールには、「URI::Namespace=HASH(0x7ff5fa032360) contains invalid characters for a type name. Names can contain alphanumeric character, \":\", and \".\"」というエラーが発生していました。結局、原因は`\$obj->type`呼び出して、AUTOLOADを実行するはずがあるけど、実は名前として`\$obj`を渡して、タイプを定義する`Moose::Util::TypeConstraint::type(\$obj)`を呼び出されました。`no Moose::Util::TypeConstraint`とか`use namespace::autoclean`を追加すると、typeというメソッドはAUTOLOADを実行するので、よく解決しました。" };

a {
    href is "http://www.flickr.com/photos/sartak/7880605988";
    image "moving-to-moose-hackathon/doy-nothingmuch.jpg";
};

a {
    href is "http://www.flickr.com/photos/sartak/7886214546";
    image "moving-to-moose-hackathon/reminiscing.jpg";
};

h3 { "Day 4 (ハッカソンの三日目)" };

p { "p5mopは`has \$foo`宣言でアトリビュート定義します。メソッドを実行する時に、PadWalkerでオブジェクトの値をその変数に代入されます。メソッド内には、正しく変数を使うことができます。でも、[\@doyster](http://twitter.com/doyster)さんたちがbootstrapを書きなおした後で、\$self(PadWalkerで代入された変数)は時々間違うオブジェクトにあるが\$::SELF(localで代入された変数)は正しいオブジェクトにあることになってしまいました。\@doysterと[\@stevanlittle](http://twitter.com/stevanlittle)と[\@nothingmuch](http://twitter.com/nothingmuch)と私とデバッグしようとしましたが、結局原因を見つかれませんでした。" };
p { "しかし、[\@perldition](http://twitter.com/perldition)さんが書いている新しいモジュールにすることで、解決できるはずです。そのモジュールはlexical padで手動的に管理できます。具体的に、メソッド実行時に、カスタムpadをスタックにプッシュされ、そのブロックがオブジェクトの値を使えるになります。メソッドが返す時に、カスタムpadをポップされます。このモジュールでは、変数汚染が抜けられるはずです。" };

a {
    href is "http://www.flickr.com/photos/sartak/7886214156";
    image "moving-to-moose-hackathon/roof-lawn.jpg";
};

h3 { "Day 5 (帰宅の日)" };
p { "空港まで無事に着きました。でも、チェックインしようとしたら、「目的地：London/Gatwick」と表示されました。クソォォ！！と思って、不安感じきました。London/*Heathrow*からボストンまで飛ぶ飛行に乗り換える予定たったのです。Heathrowのターミナル5に乗り換えるのは、二時間でもちょっと足りないのですね。GatwickからHeathrowまで乗り換えるのは絶対無理です！原因は、予約には「London」だけ示して、ロンドンは航空5つまであると、全然考えなかったのです。" };
p { "とにかく、カスタマーサービスに「飛行機の予約を変更してくれないか？」と聞いて、「新しい予約を取るしかできません」と答えました。で、新しくて高い予約を取りました。フランクフルトの代わりに、オスロで乗り換えまして、目的地はHeathrowにしました。" };
p { "怒りを減るために、Heathrowでビールと二番好きなチキンカツカレーを食べました。結局、定刻通りに家に帰ったことができました。" };

a {
    href is "http://www.flickr.com/photos/sartak/7902234762/";
    image "moving-to-moose-hackathon/tau-rainbow.jpg";
};

a {
    href is "http://www.flickr.com/photos/sartak/7902236444/";
    image "moving-to-moose-hackathon/outbound-ferry.jpg";
};

a {
    href is "http://www.flickr.com/photos/sartak/7902233400/";
    image "moving-to-moose-hackathon/comfort-food.jpg";
};

a {
    href is "http://www.flickr.com/photos/sartak/7902238394/";
    image "moving-to-moose-hackathon/high-life.jpg";
};
