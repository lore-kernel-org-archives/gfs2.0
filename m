Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123CC1A8F97
	for <gfs2@lists.linux.dev>; Sat, 29 Nov 2025 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764417964; cv=none; b=W/9Qwa3OAzWGwtWnDegG700RTmb4HAOeCaoxkfQROuC5mXv+4H8Jms/+BOQ8QiDSAuFPUf8RxfN1xFiHqzAEBasWSEe4jeWFOsTVclTo+djx+tpwb2DIZcP9X1DHXztP+pD54s97eSJuk/nqvHdc0R+X/PcyQcLyBWFv8XQ3Hro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764417964; c=relaxed/simple;
	bh=iTthXlWD+iRNNixCntvHkZM0WEKzczwOWEu1ApDNY0s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RcXRf7N6rF+x8Pt0xDa96KGlNCTL5jb/KXwAOgTraHz8u9HBSXiBxGjZb20C8phtG5L+WQjElWdan7rHwYfA45LIylOPbq8g0lxMa58k5vspLgBvK7pJie0WiSBtUUXFAxZG5A0frv/9gUvfWfgNMZIF8FoSthEtv/bzb8Sr3BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-435a04dace1so20926845ab.0
        for <gfs2@lists.linux.dev>; Sat, 29 Nov 2025 04:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764417962; x=1765022762;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEIXYF9tAoMi2W6c0HRYNDuO73OYoTKt9vuDUFNhab0=;
        b=VM7Z4HzgVJPJiHyDX0UXP98qUUCkPLWoAtKys+qhpI/ozkHiUoB67bLHy1FAVUzDbI
         TL5DevwcSG75wJ3bdiDZxgkJT62O+w5SVOMYM+GV389nr3Hc3Qdqo8Fn+OEtC1Gd5916
         uTgnjMLQLd0ySdFdiMJUVFwM9nnOG38pRio7AhA+NMZu7f80XEOsBSGtcRGof8vECVOn
         G9Qbc9hTgsuG/tTEGGBpbfElQcicgCwpayVydVAfF+WoFPW3DCVIxfb98EVjEL3ea4Dc
         1NbzsLy2lx3axiHay5N2JOx33tbzv6QTUdrMNluDhQzMR9XgA6U62/54H24CLJWPYUY6
         /AVw==
X-Forwarded-Encrypted: i=1; AJvYcCWbmYxZvBp4np7NUaGEQALkmRRsR4gZMzpWBWAH5mJQG3ljDAYlvObdstl6oiMYndvy79/D@lists.linux.dev
X-Gm-Message-State: AOJu0YwmOWlGoCKNDcwCMIKSV6Je+wGWrPCQtXewH8tTgN45DD2iT3vJ
	+Th3JzAQMvdNDSaD1XghY2ahxcQVkP/c0rCsLU5BhGOKrBwusfwo22KixO0B8Slns5gSJWVBgmZ
	PHbXcZ9X2hwvOoEvayFUOTo1ohdoqszwQ/8k8hSkpfaCaYSz8epYiJ0n/EFc=
X-Google-Smtp-Source: AGHT+IFPibTm9lFmz57pqdxTIr0MIdff/rYIv+DAUu5gAnNiJPGifJro/VrvIk4oRg7aP2Jm0N8EdIU2Qh7vL+qDBlFXoj8UuoRD
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d95:b0:433:7a2f:a410 with SMTP id
 e9e14a558f8ab-435b98c68admr218923855ab.23.1764417962329; Sat, 29 Nov 2025
 04:06:02 -0800 (PST)
Date: Sat, 29 Nov 2025 04:06:02 -0800
In-Reply-To: <b19fde40-0e5f-4bef-8ee8-ecdabbfc9562@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692ae1aa.a70a0220.2ea503.009a.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] kernel BUG in gfs2_quota_cleanup (3)
From: syzbot <syzbot+af4d53576692f8956fd6@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	ssranevjti@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+af4d53576692f8956fd6@syzkaller.appspotmail.com
Tested-by: syzbot+af4d53576692f8956fd6@syzkaller.appspotmail.com

Tested on:

commit:         19eef1d9 afs: Fix uninit var in afs_alloc_anon_key()
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f84112580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=682ece70733db9af
dashboard link: https://syzkaller.appspot.com/bug?extid=af4d53576692f8956fd6
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15678112580000

Note: testing is done by a robot and is best-effort only.
