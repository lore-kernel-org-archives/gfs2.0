Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57E3309F00
	for <gfs2@lists.linux.dev>; Fri, 13 Feb 2026 09:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770975483; cv=none; b=WKo89NojwVPWhPrxJTq1dl5o5VP1pynSr18LtoBnaLFScz/au/tzbB4R8N0zfxVLOG3aAU7dHmcbpJFk8v4FcsvEH6SGwNR5KOBEsSzm7XAwTQcfQOonzlv39wCAZ2eq8ynVyreJaLwpNvdKKTm0xImX1Xf0hBartduK/A5I3iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770975483; c=relaxed/simple;
	bh=p3vKs08RXtz8MgN/xrdoC9jhHCDCoy7xT3X7znW4sCk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OMUJb65KSF+xeMQHjsxym6aAx2u/21XxtTJPYEPUUigt+KGkewmeSDO2FK3fKWgTRd23BYGxMbMQVlZAfECAZuRsGN62PlL7KR32Ij9aTceYCe37a/azJhKQH3MUz0KzU8UTAQAf5bk8Q/tkiGcHIVNlY0SSwVMvJ2ueub+gEtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6640dc1ca05so5900262eaf.1
        for <gfs2@lists.linux.dev>; Fri, 13 Feb 2026 01:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770975482; x=1771580282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cjw3OaJ9FaY03BwjNGIAP5jwwnkzocelioQP0FwUmaw=;
        b=XcsWG37DK1nUDgbU5gltft0jYzVy/e3gqlQtcmGf2x/WCJqbvW0wCImUkjrlXswXhs
         AsB08BPm9mG05Vjiz1WGkroppPfx3SjHD4auSiWEJ79vHeMWxOwlqEztm2QJm8Yc2qsU
         uw0GkCfN0Aw5GVoOzi+/01RT+gf//FExfh5fKTwjquiTkRkZjvb6ZVRn6lopAzy00nX1
         vleMsKz8HERMBrw3JI09s53YSs+70xrUaGcSOcYq5edsT3eYfsim7ivbDLenzyV6Gqpv
         T7UhnZENx5kRRq2FQJA3VTC410hadgFH64mLn3/FB0xpLrZb/xJbMLhdq9uqgxlJzZnA
         T/uA==
X-Forwarded-Encrypted: i=1; AJvYcCXh/FDe3Qu0YjGxs2V29nHBm/bZkF4lVcUE6jBEmzn016ChI3iaG66TJisiHBzYg+gYpmDZ@lists.linux.dev
X-Gm-Message-State: AOJu0YxCbHTKOeJUgkfX6IV7vFyeVZ/m1C6mmkEJVMnxuA6y4jAw5i4A
	FvgfcpJuDbv4f8R64t7zLkju+eEiHMI7qrrUkBLdykzpkrZ5rBWH/ZAigKOsNl5Lmz04Fb+sDg9
	vpYy4O1CdCjpavvoX2IohKuDaxwwliuvg7vPa+5BkBSfoIj7wOBAbrwQeHUM=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a4a:ee0c:0:b0:66a:adbb:31c5 with SMTP id
 006d021491bc7-67722c5a5dfmr853976eaf.60.1770975481850; Fri, 13 Feb 2026
 01:38:01 -0800 (PST)
Date: Fri, 13 Feb 2026 01:38:01 -0800
In-Reply-To: <20260213092133.2440431-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698ef0f9.a70a0220.2c38d7.00be.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_remove_from_journal
 (2)
From: syzbot <syzbot+cff8e1b82d7911dd051c@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
lost connection to test machine



Tested on:

commit:         cee73b1e Merge tag 'riscv-for-linus-7.0-mw1' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=119b0722580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df1d67d06552de89
dashboard link: https://syzkaller.appspot.com/bug?extid=cff8e1b82d7911dd051c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1196e652580000

