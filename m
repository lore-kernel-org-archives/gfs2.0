Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA073594A
	for <gfs2@lists.linux.dev>; Sat,  4 Jul 2026 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783123651; cv=pass; b=kgUSl5gcpB6zlRRt5h47zbUnJKMBzxUCdxMbJ2xmhxw09nhMFAkAdo4U5kp1RQX6yHcOQOYCTJox2XWEpO9awpjY1N33XvrpxEzn+pkwcGLlQ0JnDd6RUYFFnobEifWgowecllczTBt5XF82o6NsKBGlxlLCudJ26ITbPRhtUHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783123651; c=relaxed/simple;
	bh=vDHlcWmL4Cd5UT42ugQTjRnKNbXE5dy2ocFAsQoM96Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LD72R5dNcYbvQvGNyUWFSlZy8w+vPXzyEERDZDpCZWU89J9xzBFz773aNWu92FTbA5Y91A05WUqv9N5bAPcIF3W2aqKkLQWbLFvLtb1qxhub41QWuh1I/YBlJDTQfgzygnGVC+1un5ArVc+qLzyrou9A4aMhHhqu96zD38dgGgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBbA/JmH; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBbA/JmH"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4703bc0a99aso600246f8f.3
        for <gfs2@lists.linux.dev>; Fri, 03 Jul 2026 17:07:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783123648; cv=none;
        d=google.com; s=arc-20260327;
        b=bk6jh9dRuhZvbhqeLSYq2o6f8Ro6GyvhLn/rWgfQc0cN0ydj4r79FfqmdM860hSK6h
         fmnScNDVxqvmaO1XVOLv9JziMWrqCBWIySDW0yqt2X2drIX5c9ukK7b+IeiG2U8giGJZ
         dG6sGwLk7zh50qvrI69soME4O0gbRM9t9Xhlm9a2rAhZVuKABS1AAROxbKxA+ahh7M0x
         8tTr1yaJsTytE2OANhtkjJkQSt51eB/jiUhUqY/SgXAUbz4p87aLX770Jzfm4qPRVXgm
         gWV/6rLFp3ip/B/oCbqxdAbiqgjFAy5uHKToBy6cwxy2UtrvSu7I1hVtBJhjDtWC30T/
         r6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vDHlcWmL4Cd5UT42ugQTjRnKNbXE5dy2ocFAsQoM96Q=;
        fh=EFl9CUqSVB5jQkop2n+LP3m+jCZH4GV5YoCSIXdGQ9A=;
        b=qVI0IXuBtBddoRv6ZdCklkFzLugFSnsALgvq1+eTctYFMrj4nt22fRA4+U7HDrVmuM
         68PHKZJ8sfFWdgt3WpGGPC1g4WjfIYwt/sDo1fMAgSWq242sj/XCEnTDuFCLkum9O61r
         9028fySa2b8IN5zfwe9LNOAMwo6CuJF8FZH8bNzxxnQhma/yBPVvgBSNQQqL5i+FRE2N
         re1vZ/xLbUmJxWqaJqyKWIWq7dEjIQ7/CxJxd6QTFGmZ6RTWbJ+89ZVnf+k+djOzfPt/
         1eZZVQrdImHSk0lxC07oovWCaqyLwUPR34DcTwJS0DAPGDNRMqb3p/pzBjKi6Ko9YBQC
         wnNA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783123648; x=1783728448; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDHlcWmL4Cd5UT42ugQTjRnKNbXE5dy2ocFAsQoM96Q=;
        b=LBbA/JmHuNiBUUPzuZUic/1JhXsx/jqf/OapY9sgx9jihJBTe3q7sMm++hQpKtwIrX
         gTU5zYYjX7y6RKxHFEbPxRqboYISe9embdg2mOHIrHRyPAFns7cBwYJ+2pJ4KSZE/oHw
         SlN5D6H6X1EFA8grDPxenJjI309Qwfxaa7oik1rGaVLQwpT7k4Up9KECKzRVDGILBzaT
         CafTHNztnnHWPw1XfxG/RWZBq5eRtwPkhoWNwZ6n3lxEck5rqZYAUpW4R4RH/h9dZTcB
         VZ6C93ZOLSMq/4DqZXw67DNkzRT6bckeBWrk845bC8f7q2BjzMe438FvoJ7jorLpk8T5
         CgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783123648; x=1783728448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vDHlcWmL4Cd5UT42ugQTjRnKNbXE5dy2ocFAsQoM96Q=;
        b=qR91IpxJeUq31adcawi2lzkW4CM+YWN6/6iGwmSUTVzO1XMJwZ3Z7eElcTaSNbfOiE
         Y2tcpKc24GbEmmjc1eUl3DAsJUXb16BLYl0sSpe8MVysKu9Oa3Ort6PRa9LNiOSgr8Uw
         gtweb5oxKptLoSTXQ3UDrzHBioHcrekCmUV7muHZRSb8ympQ5+bpvVXlEXrEkUOT4eRx
         DihSQH9Qz1oyuO8w0S1GeNUDIf8pmPabnxXHR/MRVdxvcXMoxhETrUX5ufH0TaAEWY/M
         KA6t+bpOS60/ueyamDEsTFZtkQ7OHMcS39FYEG+FVWLKjWalMm/Wt719EqeFAbx73ehH
         1eKw==
X-Forwarded-Encrypted: i=1; AHgh+Rqmg0kXa6rma3sTM5jDP+cjT95uxmCtuzvruHCMJCmvFmfJ1+7fp4Niu1OLuqXeZVgcf/am@lists.linux.dev
X-Gm-Message-State: AOJu0YxFgV0ORjpwwu1HKz93b3SWtWWYY6i2UkqYogxTnsF+Q9jK7NNt
	FVu4IeZkvBGydvWxpMJ5UEnJWZ582RMd01DFVgHHaP2XM/xukeV7C+2RcIdPxPoYuuzXLwfF5xB
	fCGl/5ORTYS1D+l5EKl9wuX6WsyE5sL8=
X-Gm-Gg: AfdE7cnmeX0z6hbLGZgRSQj6CbGOC9/PtNcINetKW1953w66vKn3N01y7ZzIYNB11Wh
	afTgJeOL2LAeXa8qgYvpMPDYpyTKfn8TYFMngQDG8IvRxXCKg2W9knnlCx3TixqOVa+Jb5bYlzU
	qrSl3OSq2edNxbSGeGMqeYDBTIz7N2mgwt8S8vp/HZRiSP0b68AVVN4+Me45MD1F7MoPZqhGI5w
	dmYczdGJRzMtIUnjkuGfdzOemkwI+PATBaRhktLx05js0Kpa6qzwXt7rCEu3YIyXYF9ZQDAAVa9
	TZzgrAZjAS2rpjeu3YSZv13qcFCAYjiwOoDo65L2ydry4KJxHIqG
X-Received: by 2002:a5d:64c8:0:b0:472:c426:2ce9 with SMTP id
 ffacd0b85a97d-47aa9699811mr1527073f8f.12.1783123647923; Fri, 03 Jul 2026
 17:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
 <20260701000949.1666714-13-joannelkoong@gmail.com> <CAHc6FU76J-YYRd2B=ZPN2DMabQjkzgG9qSzbP_S1s9AsSJNh=w@mail.gmail.com>
In-Reply-To: <CAHc6FU76J-YYRd2B=ZPN2DMabQjkzgG9qSzbP_S1s9AsSJNh=w@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 3 Jul 2026 17:07:15 -0700
X-Gm-Features: AVVi8CdQdofMwGUqV4tTaAHxeI2fygjInGMJJOumzbFcOuGU31GOE644YhYA5nA
Message-ID: <CAJnrk1YmAjfSvkX5M0mu_ts_7APbp+Zfrz0KU6BMgM5fxN568g@mail.gmail.com>
Subject: Re: [PATCH v2 12/18] gfs2: convert iomap ops to ->iomap_next()
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: brauner@kernel.org, hch@lst.de, djwong@kernel.org, willy@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, 
	"open list:GFS2 FILE SYSTEM" <gfs2@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 4:45=E2=80=AFAM Andreas Gruenbacher <agruenba@redhat=
.com> wrote:
>
> Joanne,
>
> you say in the cover letter that
>
> >This series is submitted against Christian's vfs iomap tree, and is base=
d
> > on top of the current head of his tree (commit f2727952b21d1).
>
> which repository and branch is that? It's not vfs.iomap in
> git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git; I don't
> have a proper merge point.

Hi Andreas,

This is on the vfs-7.3.iomap branch [1] on the vfs tree. This was on
top of commit f2727952b21d1 ("iomap: add a separate bio_set for
iomap_split_ioend") but it looks like that branch has since been
rebased, as I don't see that commit hash there anymore. If it makes it
easier, I've pushed the changes to a github repo [2] that's on top of
v7.2-rc1 in the main linux tree. Sorry for the confusion, I'll include
a link to a pullable branch in future versions.

Thanks,
Joanne

[1] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=3Dvf=
s-7.3.iomap
[2] https://github.com/joannekoong/linux/commits/iomap_iter_next_v2/
