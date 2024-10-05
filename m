Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10424145348
	for <gfs2@lists.linux.dev>; Sat,  5 Oct 2024 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728146765; cv=none; b=AvdS1WpxnFcRZUqZiaCC74PeFjBgZ0CYziIxkr+WnbJ3GVC1XYKxifO+BaAuc5CrEcQlhzPkkw1HomeRbr/ef4XYWEo7RFD2z8sQSo46RMmQiYAxXY07T/TNVFmJZGBBinyQQNDmZN30x9LBjrM5Rcr/087P/hyVvHCuYlva39g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728146765; c=relaxed/simple;
	bh=N4+9eDhAiNy2e5iD9XNdnPLXGDPzbKIYlzPHPZvnZqI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sW1VW1yJgPKYDmLFvIi6tE4vrtmKXZDMBoBY7Km3xoyFrbMLMkkocVnW6az8g2YrQuNQZvUUGej0w0o1Hscd7MEbOUA7cl99W5KYWosshjtPJvNKFpFMmjT04iA28NNDX2k/7rQ5oWwlkCM94Tf4bdQm5HFlUnA0oOaj1ANY1VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a343c444afso36889945ab.1
        for <gfs2@lists.linux.dev>; Sat, 05 Oct 2024 09:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728146763; x=1728751563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68ZwIv7g30+vGS9vxVKNzk46cmBH3f5PDAU+ZhypUrc=;
        b=Rqo+sLrdUsqx0EexE+P/XCdhxxqqKzHUdEmJzdRmAmqdVqxTHz62F2/vhd/wDj6wgl
         6ZZpM+rMekw5hhJoBo4XifmRtRb2sjla6dmPUvQbRJpsaGUdWLxiDH9XSlYE5E4LQRB4
         2/cRz8YeXlGFfxqp6jZY3woY5o6hPmWY4xEzF3ajKH2RAMoXNuZQUlPxCSSLno6Q/1PU
         EHCT0FlDW91C/q04YfL9Ho3sL25l6EFL2DcTYsjYJlZ2u40ZW0A9VhaI3vGl1d93eRu1
         cbW9qzxtHm+jS9yrTI0DvRCa0X3/JaDv7LyeRrm3eFEljkLX1yGj0LqjAAjDa2wDZcT5
         wQEA==
X-Forwarded-Encrypted: i=1; AJvYcCVvMYzf8b5Mp+jJqbppOU9S0PMEqeazSTfHvnX6SBOgdGg7mTxT/MeG/07JNmd7nQlo2qQe@lists.linux.dev
X-Gm-Message-State: AOJu0YwJDmMQ863ziKf00Xv/rfCGYsUnNlWlXJQHMMGf/a2nP26+nJoG
	LYEMjWnbpj9r+TvbVAU2LNAtOd6xhhif21rX4D/LA9rDb7Fml7Df6eUXPbEGd2/FQSkFSSaZxcO
	lqeVPHrbBSZgAem3lruSD2W5rtxAXqEXB7PnU+fs2qncyd2bmYMxp/JA=
X-Google-Smtp-Source: AGHT+IENKnJpo75wS3EtRYAKZr3l1ybivi7xEmOdy+pzZ1onge5giIFWnIRqyKkGXzVCDZXVpuSaCFf6fS3LtxHNYNnqMNp7w0j8
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a92:b752:0:b0:3a3:778e:45cd with SMTP id
 e9e14a558f8ab-3a3778e472bmr38289125ab.21.1728146763281; Sat, 05 Oct 2024
 09:46:03 -0700 (PDT)
Date: Sat, 05 Oct 2024 09:46:03 -0700
In-Reply-To: <ZwFmiv0lqP02xPtq@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67016d4b.050a0220.49194.04c3.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] KMSAN: uninit-value in inode_go_dump (5)
From: syzbot <syzbot+aa0730b0a42646eb1359@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	qianqiang.liu@163.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+aa0730b0a42646eb1359@syzkaller.appspotmail.com
Tested-by: syzbot+aa0730b0a42646eb1359@syzkaller.appspotmail.com

Tested on:

commit:         27cc6fdf Merge tag 'linux_kselftest-fixes-6.12-rc2' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11923307980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cf7bb3f15c72e66
dashboard link: https://syzkaller.appspot.com/bug?extid=aa0730b0a42646eb1359
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16bc7bd0580000

Note: testing is done by a robot and is best-effort only.
