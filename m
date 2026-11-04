Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793787783;
	b=2pHs2w+ZzCTjBzw1Pv/F0UR7Gab51m45UoAS9dmquLDJnyAL5fIDVXVv02Hsz0Hig3jI
	 A9gVoHDJMDzWNt77kerky23cED2OBJekaoT2D6R/eAP3Vh2gWL8EYAUmna6Dv0usWcHM5
	 f2wSJL8TyH1o2PEeDGjrByQirPUwryf7eAFRVxsaZAOpe2OQY1No6YO7X6Q6iof1bFxsk
	 w6lq9DQVwFTCbIQXsVvYO3axhCKNGmqZAKgYbywLqdiAoQUhu6JZRzcoggaKOe8z13bqF
	 ZgpUZmRZnGxkMsL/ZqxHL31RKnvSA1232s0BuOGyZK4e2AbNJLFDrA2USuLMgxp9QWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787783;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=in4uu/6jU5K1TQw6OtPELk24DSSrt72HF3lVYXCjGr0=;
	b=f6NgooahxALy7O6sx35OIHNQdYp2nDUT6bn9os11CTzn+cSILG5DaPrfoAVIuEPRvieQ
	 6u8p+/TtD4zcc9O0GnZzMej3ikDx5IZFb5zIgzH0WQrMen+eMv3vB25WnANdrWvreqEkq
	 KOv1gKhX6EM34m9oYYItZh3x+ftz1nKQI6CpCz8RqVY9yg3qhfgI37fGNmX0c/v2kU6Op
	 ry63NnW3ja8u9aZqNkQG0QW3qvSzv13TxYasR5lhAgfGyDdv/IK26QXxElN8IDuBjrvm3
	 GehGK2h6KQma7xQCRjEgQckqOv9Y1OMory6tuEnX8SO1IfKjSwX9Q3rh0gwDDEJ9X7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.71
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0E2606A326
	for <gfs2@lists.linux.dev>; Wed,  4 Nov 2026 10:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D0E2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-821de0b7baaso677216a34.1
        for <gfs2@lists.linux.dev>; Wed, 04 Nov 2026 02:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793787782; x=1794392582;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=in4uu/6jU5K1TQw6OtPELk24DSSrt72HF3lVYXCjGr0=;
        b=QEW9xqH1jIYKADEdtLgJR6qoFeBZDY5z6gZuDsgcoKML9ErfaYW4x9WhtRl+bTdI/+
         wV6tLn71VXSXptxqRZXFALIQ0rejVraksSfqmW7Tbvoa1p0dY/hocCt5FxHAQgs5ggLl
         +0k9flf6NASckCsOGBOdeQYXFJUfmBiOES+wd4XR8ZJLUDoMWx8TW8W4q2FO98ZnVbj/
         FsTi6+GPB1qYVEgYPt9n5RfFvDPC8WdlM7Qfziw+/TW6i28iPg2F2SX1Xx9skum/ovSk
         qtPXHreDHan4K0xsmtA9XGUEkJycaDVs3Ul9f4Eot6oNmaod+CXd46SEaU184SQ1hjHz
         vEnA==
X-Forwarded-Encrypted: i=1; AKwUvBzmUHhRZFumL9tqLZ7yPoXEPOtWYswChsw6UIoW7UyKBsUlwdAUxNwa8c0LoaqgP92GjnJ/@lists.linux.dev
X-Gm-Message-State: APuU4Z/1eAUzTlAHR02LA21/B9fqxW5AL8q/FcOLsGleKcZa0PhpFsYC
	9smO2XP/M7l1AFqxod02El8lk+0Hz9yXlP7YND1mEIRXVjZlKFYGJJM5bf4FWmj2AWr4gY6z9m0
	hn+CbgJDIU5NDXe6vSFlvXqftEqf3Zd7c6JTNIwZ70DHKshMlrt4eH4jXIzU=
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:151f:b0:53a:e153:e8e6 with SMTP id
 5614622812f47-5640de7d903mr11089160b6e.59.1793787782323; Wed, 04 Nov 2026
 02:23:02 -0800 (PST)
Date: Wed, 04 Nov 2026 02:23:02 -0800
In-Reply-To: <20261104095530.4178727-1-diasyzhang@tencent.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aeb0786.3c6f2eba.20048d.0001.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] kernel BUG in do_qc
From: syzbot <syzbot+bad65435361712796381@syzkaller.appspotmail.com>
To: agruenba@redhat.com, diasyzhang@tencent.com, diasyzhangqing@gmail.com, 
	gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
lost connection to test machine



Tested on:

commit:         05441d69 Merge tag 'cocci-7.4-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1554a055580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e29ebf56758bec63
dashboard link: https://syzkaller.appspot.com/bug?extid=bad65435361712796381
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17f4b2dd580000

