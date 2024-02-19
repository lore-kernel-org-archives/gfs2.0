Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D3B2D605
	for <gfs2@lists.linux.dev>; Mon, 19 Feb 2024 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343888; cv=none; b=ACYgwsCaCxvbjM0ZDrXaXhmEUHC0qRtxy272XNBPSemNqZ8hClivc9U4xOA+Rb6NrxfzxYtu641vPpEFY4omcnAfmULGErw8m9gRohE5MQ34lLYqmAUDw0FiRR8MfCiGgICCz94hgoO0UYX0xpoEQWITY9iNqLUxuAcdt9foG+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343888; c=relaxed/simple;
	bh=TQmW0k0mrrJtpAYMPKSa7ihRnBCkF+V4hHMWThy4tNg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YYpoD5iO3CQRPbQHsaa9Q2Dx9GcIiSRFjG7wiZgIZ52TaXsv48Gf5UzK/sU4PdHiwavh/MV3ilryCFE7cUzA3tbB5fSIK0y6kjA1EbEjIRBqPRZ9+MNPw3mjQBVCW5KgHCFIQmVkNbdEJ+oNgNA5gkP1jWmmsrtuRQmxP6321XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3650280b271so21036905ab.1
        for <gfs2@lists.linux.dev>; Mon, 19 Feb 2024 03:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708343885; x=1708948685;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOT/FQ95TWde9g78HBgFYpuNfXwzNoXRLXzlXD9GSII=;
        b=fj6aDLtLkG1e6r1J4b3H7SjCi2+q2RhVoscChQTB4v58Bz8M9KV+kqogDf6LaGAZ2B
         7IO38CelfwwYKIENHrs7CuBMHEX+9tUSdKP35KpZZ9AlaQLa7CxRNbRM2LYTdC4Sq9/K
         RGgarSFmNbKZGKObeJB2UU8Ouyu/rJ5/32zK2AJKQltixfsx7cPoN5HF+0cZYhm2yiCw
         M47n02ycvUthxJ77u78I7FLJS8yhj75ihGtdbE4Xiy/m6M6B4P/uYvDjCVW+FEadT/qx
         XhqZPs1+MzR4VbaoklzLijGgKzqabbMl/cvcs8emNQbHm5ygiMRWlZnBLsLWENACuOpF
         +uTw==
X-Forwarded-Encrypted: i=1; AJvYcCUcmK+jFFhIiA0yoAXLOKI+EtQA1vj4VI68Ezo29nf74doIq5o9WpNJxPXRILoakB1YYFQFtSiuwFGhotdYxkGg3YqzQQ==
X-Gm-Message-State: AOJu0Yz9eeNPvcOPCVYzqYOvoy35dOBvpRxGmqSYgQ3v0+zFlbCmhc4B
	mnGINgsm3ikPjZZtsVE6iIJoQmgRm0OEGij32q+Lwx0BVu7ErYyfR6yNisPDYl2/6bBlW9I3GTW
	ngxweptgtQuGAdGA4upUEZPhIlnnWgZam0MHznovSuEvffGKdr4aUed0=
X-Google-Smtp-Source: AGHT+IHzjLRsBmpEd4oZ2sh+MbTV5Oxsu6nOCTZ6wBZQxqKeFpAy7GVq3CUuF1jwCIbUmS1x3hblykLa5NZxVHGCoIjqeitDcdaJ
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160d:b0:363:df76:4a1f with SMTP id
 t13-20020a056e02160d00b00363df764a1fmr964199ilu.2.1708343885808; Mon, 19 Feb
 2024 03:58:05 -0800 (PST)
Date: Mon, 19 Feb 2024 03:58:05 -0800
In-Reply-To: <00000000000050a49105f63ed997@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077ce280611bace5b@google.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_dump_glock (2)
From: syzbot <syzbot+427fed3295e9a7e887f2@syzkaller.appspotmail.com>
To: agruenba@redhat.com, axboe@kernel.dk, brauner@kernel.org, 
	cluster-devel@redhat.com, elver@google.com, gfs2@lists.linux.dev, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, peterz@infradead.org, rpeterso@redhat.com, 
	syzkaller-bugs@googlegroups.com, valentin.schneider@arm.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14238a3c180000
start commit:   58390c8ce1bd Merge tag 'iommu-updates-v6.4' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=5eadbf0d3c2ece89
dashboard link: https://syzkaller.appspot.com/bug?extid=427fed3295e9a7e887f2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172bead8280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d01d08280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
