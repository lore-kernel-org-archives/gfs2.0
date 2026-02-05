Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0C8366DCF
	for <gfs2@lists.linux.dev>; Thu,  5 Feb 2026 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770280863; cv=none; b=WgWA53Kne7bVaOJcRCG92Tchlq2ksuPzshDdToO07r/Qg20+jP75hbAzXuBv3t65tdkIsXrHfkSVMMFph9ElUOMggYvw2QNMhCoMVM9Ae/nWuvjbC5A65AUNDbo6vFzOeNpASvPC3dXqtOg4gXjrJJu7YpI0PMaLvFAmHj5i4AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770280863; c=relaxed/simple;
	bh=oLlnw9o/uid4GysaEPX0KM5niODCLQY4b+eJWfplsRI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Njdi+l2sg3jGZCw9wTvysCQlkY3VfPpej8UYm9CxhV34aGqytfLh8fPd+TNOnbN7Bloh27vn272UPn5NldezFRCw46JETYkl+dseDg7hhE1F1cM692e/Ol9RUDnAJG9FO5/uAwqSk1hbkoBAgpPvpZhbh3kn7IJfZo44imGjBa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6640dc1cb33so2993623eaf.0
        for <gfs2@lists.linux.dev>; Thu, 05 Feb 2026 00:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770280862; x=1770885662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zeo71xz4fsF9z64TnJXcNsqIXoMPiwhcmSTfd/2gMGk=;
        b=sqRRtYc0e31MBSO5KnkrCvIgCCu9UclXsmhzPBAxHDP9LTW3MrLa14MJ1IYohXbjTm
         cgyMJEwTlePWLmZgTv3sEhTdDHIa4ufHqSU6WPX5eqJYE8784FjIbBU7dPSPrJbZ05e8
         0+3zEZKK8m1loc00EL4KtxU2eSAGLKkGnUGySDQNfwk2jv3daSA5SvC7dT67T6Bn4Ix3
         5j/Quej4J2CoGLyEn9z83SBVVhGUcQ9IblsR48BQGfMSyVh139/XpJ2WzvDUUtwIL0EX
         ntE++6bkZX2klvTWD9s/9CVL7Sohwqsk34PX0IBONguevf/DBaX+EkQ4dStHMDyF9VY5
         CFYw==
X-Forwarded-Encrypted: i=1; AJvYcCWSSPMsajFw+I3ck19hoSYR0ft2IMVSl4nKeq4opNenNIbBVpfFg9UJuEV6U0dGlbn2n8/g@lists.linux.dev
X-Gm-Message-State: AOJu0YwDYdxj1pzvpF4VVf+tsqu1R7iKsG996O9HZK/Xdf9h+t9+P7Nw
	uBmQrZkCGVbIe9m/abwU0QQ/bYpXAGCBbvP2CIdRwu2kUdOTGbTHaRGK1zCSk7VRraZP1b5+hM+
	cP2ZiJiNbocCGf4Uzn7sFCg2D0BTpbvpM6dVDXpJmtq2A/zaSxxen55N+SM0=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1621:b0:659:9a49:8fb2 with SMTP id
 006d021491bc7-66a229790b9mr2776443eaf.43.1770280862060; Thu, 05 Feb 2026
 00:41:02 -0800 (PST)
Date: Thu, 05 Feb 2026 00:41:02 -0800
In-Reply-To: <20260205063145.1039526-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6984579e.a00a0220.37c87e.0026.GAE@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=13bc8a5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7d0fbecb37bff8
dashboard link: https://syzkaller.appspot.com/bug?extid=e57495fb65020ac7bca4
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12710a52580000

Note: testing is done by a robot and is best-effort only.
