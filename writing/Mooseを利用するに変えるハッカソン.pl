use Sartak::Blog;

BEGIN { print "title: Mooseを利用するに変えるハッカソン\ndraft: 1\n" }

p { "Oslo.pmが「[Moving to Moose Hackathon](http://act.yapc.eu/mtmh2012/)(Mooseを利用するに変えるハッカソン)」という会議をノルウェーのプレーケストーレンで開催しました。私は参加したいでしたが、招待頂きました。Oslo.pm、どうもありがとうございます！" };
p { "会議のテーマは二つありました。1つは[RDF](http://act.yapc.eu/mtmh2012/sponsors.html#perlrdf)に興味あるコミュニティが、Mooseを利用するにモジュールを変えるつもりでした。あと1つは、[p5mop](http://act.yapc.eu/mtmh2012/sponsors.html#p5mop)を屈強化して、もう少しperl自体に追加できる状態に準備する予定がありました。" };

h3 { "Day -3 (YAPC::EUの日)" };
p { "ドイツのフランクフルトで開催されたYAPC::EUに参加できました。初めてYAPC::EUだし、イギリス以外ヨーロッパに行ったことがなかったから、とても嬉しいでした。YAPCで「[Mooseロール利用パターン](http://sartak.org/talks/yapc-eu-2012/role-usage-patterns/)」というトークをやっていきました。私が今回は全ての前回よりよくできたな！と思います。きっと来年のYAPC::Asiaに行くことがてきるので、たぶん日本語版を話そうとします。" };

h3 { "Day 0 (旅の日)" };
p { "フランクフルトからスタヴァンゲルに飛んで行きました。ホテルからフランクフルト空港に、そして飛行機に通った道が分かりにくいと思います。中央(Hauptbahnhof)というか駅で乗り換えの標識が読めなかったし、空港のゲートを越えた後、バス(!)で飛行機に運ばされまして、道路から階段で直接に乗りました。ビックリした！" };
p { "結局、プレーケストーレンの山小屋に無事に到着しました。" };
p { "皆さんは自己紹介したり、喋ったり、一緒に夕食を食べました。p5mopに興味ある参加者が「基本的に、どうやってroleという概念はp5mopの仕組みに合う？」というを夜中すぎまで論じました。" };
p { "[\@robinsmidsrod](http://twitter.com/robinsmidsrod)さんが「日本語を入力する方法を説明しませんか？」と聞いて、私はもちろん嬉しくなりました ;) その後、XPathとかXML::RabbitとかUnicode CLDRとかとか喋りました。" };

h3 { "Day 1 (登山の日)" };
p { "早起きして、プレーケストーレンにハイキングしました。眺めはとっっってもきれいでした！！！" };
p { "旅立ちは10時から16時までかかりました。たいへん疲れました。足が痛い！" };
p { "その後で、Fluxx(zombie版とcthulhu版組み合わせられた)というカードゲームをやりました。計画者はプログラマーですから、法則は面白くて、進化することまであります。" };

h3 { "Day 2 (ハッカソンの一日目)" };
p { "朝食から昼食まで私が「Mooseロール利用パターン」というトーク拡張版を話してあげました。昼食の後で、[\@pmichaud](http://twitter.com/pmichaud)さんが[NQP言語](http://pmichaud.com/2012/pres/mtmh2012-nqp/slides/start.html)について解説しました。プログラミング言語が作りたい方は、きっとNQPでとても早く計画できると思います。しかもハッカソンの間で[\@pmichaud](http://twitter.com/pmichaud)さんが「ちゃんとドキュメンテーションが書きたい」と言いました。" };
p { "[\@perlyarg](http://twitter.com/perlyarg)さんとMooseのロールテストをp5mopに変更して始まりました。p5mopではロール合成は不完全ですから、そのテストは便利だと思います。" };
p { "最初のp5mopの拡張として[mopx::instance::tracking](https://github.com/stevan/p5-mop/commit/04997c0c93c7)は、私が書いたことができました。とても簡単に、p5mopのClassというメタクラスをサブクラスして、create_instanceというメソッドにオブジェクトを見逃さない挙動を追加されます。" };
p { "夕飯の後で、昨日の旅だし、朝のトークをしたから、たいへん疲れました。で、やったことはFluxxだけでした。" };

h3 { "Day 3 (ハッカソンの二日目)" };
p { "先日書いたDTraceプローブをPerlに追加するパッチをやっと送りました。もし受け入れたら、5.18からop-entry、loading-file、loaded-fileというプローブを使うようになります。" };


h3 { "Day 4 (ハッカソンの三日目)" };

h3 { "Day 5 (帰宅の日)" };
