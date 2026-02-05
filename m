Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E1035E533
	for <gfs2@lists.linux.dev>; Thu,  5 Feb 2026 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770284163; cv=none; b=up+IEIQPrq5kPL9vV4HidKNturHxezEdmXjfGD4BXKXM90klrZak08Qb/fpEsur+iS5vM0PDG4ulUxvOLoYp4kMoBZRaa1sTg3bqz1+XNeN3VLA9KoZ89+C0lBNsu/SlSyVspB91TNk0ud6e5Wz4cjvjsO7A16/+/KX+jejHFns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770284163; c=relaxed/simple;
	bh=EATmww2TME9Kr5PrH1HF5ubj5KXFOLbG3S5DEzUYO9U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pvilWkxpOr2Jqo58MYYnY6NOrYqHmHqa4LA13fKNVjQaYYo98Vm4ZF3DSVBBDEp8/sUbtSyn2fdLEmt4fQQwa4FyNA1inN+7zq5cCaywcrqlesTzZN4zKioWRhtP1ZVfVJpjGX4QGfMVr+ALn5XEptiH/iZXS2OSp8a2PyoZehA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4088136faccso1699399fac.2
        for <gfs2@lists.linux.dev>; Thu, 05 Feb 2026 01:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770284162; x=1770888962;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kPCtQS132ZJTgLzWTUrXG3lZFzazAmWuFvYNxYTo0Aw=;
        b=pLm2+j8ItcTv8vSlur+/tn9LqIZGgpGM+TCMi2XZeixuEn2xjhxe4yXGTfxBqOUayC
         BiYZxL36it1rTm09LvS3RWMNjaNyUjg0N3ZpD3IMZBfcLn8tUifh/Zpl92qwQIgndUkY
         bWWdxE/cZ9LTh1fSKgDCPedwI+8DLtJuj60qfkJsu9jcnhx9Qk1SO0gcBfrdP0hCcWKR
         xstXhizUFsopjmXgszF+Luwupbdmgkw4NnbTPWLjlm+S2V3KR/gpPAblebtQ3jhvzfFf
         EmlAQyE0yYyDwYTRkOLDXk3+JcZ5wxt0vQ4iE2CP+uCEX+H3+RN2+AxRORTqYuCmyrqU
         msKw==
X-Forwarded-Encrypted: i=1; AJvYcCWLAJaaYXwZruIqYJY9zZW8u0pfvjRbmTUHY5cKzufBd9IhTQp4ja0gGquIhr7GIx+l8IyW@lists.linux.dev
X-Gm-Message-State: AOJu0Ywf7R0O24b4h9wbHqi6z9N8mlAQ6Sy5ApMBOJoHwzm4WLgvYlDu
	xeEFcVvEMa3Az1Z+IQ/GFgQKM/xHKhCGRkjRIH20AxxS5bZv3yM7VF4DtIQ15QR+xmN6HYaO4Zm
	nbTvb/D2XNqDfqiJFS+FaqlHo5IPUh8PRkgulr6ZCYjaB4xHuP6KzS8/biS8=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:201a:b0:662:bf74:ebaa with SMTP id
 006d021491bc7-66a22692851mr2950301eaf.54.1770284162649; Thu, 05 Feb 2026
 01:36:02 -0800 (PST)
Date: Thu, 05 Feb 2026 01:36:02 -0800
In-Reply-To: <20260205090628.1105496-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69846482.050a0220.3b3015.001d.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] memory leak in gfs2_quota_init (2)
From: syzbot <syzbot+e57495fb65020ac7bca4@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e57495fb65020ac7bca4@syzkaller.appspotmail.com
Tested-by: syzbot+e57495fb65020ac7bca4@syzkaller.appspotmail.com

Tested on:

commit:         f14faaf3 Merge tag 'tsm-fixes-for-6.19' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138c30aa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7d0fbecb37bff8
dashboard link: https://syzkaller.appspot.com/bug?extid=e57495fb65020ac7bca4
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=103eda5a580000

Note: testing is done by a robot and is best-effort only.
