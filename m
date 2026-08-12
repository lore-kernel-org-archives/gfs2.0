Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F0E2D876A
	for <gfs2@lists.linux.dev>; Wed, 12 Aug 2026 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786498589; cv=pass; b=m3Cu0rMcDr02OLfWxFo0oIIigE8A5VcvL7TwEk3HOrKi6KPVHTXpdqNYCVKSanvUMIJszt6iNPnqybws+WtRj/c3LOxgVFJth7QttClbgXtAZPs+zYN3Tv1UqSAO7V0FN8Sl4b8ADILm6P33Qnuy7xjj0rySKP1rKDVeqGUsjFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786498589; c=relaxed/simple;
	bh=+uEcG0/gYvxHHTbJfeKbD9uuwAsPTQX2h4z9JikyhiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+q8o1l5vjdmuZ/aZJgAU1b0PGKeaxumnVNLDP3UNfiICDb9bMmZ5ZyEzx+AIfxEZLvNpzwapDNt4HaaP/Yex1NsvWZgQ9hg0FNh9npdOQJKQYQlUAecUPn1CH0RS2yu6c+gY4kfdjIaFjIxgcABThjztvJXOeRuFxiaotr2zco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCxmCTs9; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCxmCTs9"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so55602566b.3
        for <gfs2@lists.linux.dev>; Tue, 11 Aug 2026 18:36:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786498586; cv=none;
        d=google.com; s=arc-20260327;
        b=drkxwgMof/ZwXmd0k0DXTCLRbp2ZItH2c5HYAw+j/M3B1n75fmngCU00j9Twp2StVY
         L7fOr5ut7Zi/2/LMa9h5xDth47485HsMKujWouZqM5VLRhJNLZCCxBUOtpEze2HkgGQS
         EO+WGoKYRkdu/cMUNqes9ZQ7SD6D5XYJwk8/06MmRZh0cejDoJHpuNx0JSC7e5mCjvOW
         QtjaUVZRgSYje+iHQoxfM8D3MzrLOj96WkoKUgHSaT/Yc4hFFR0OaTLyHdCjzp9VjFzl
         35XO4a8HLMbLeA1MwX7s7Z+myaqcC+uII9BnTmurpQtFxHLyy9lCzt37oyi78GSZq+Xq
         qCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TVVQmkJCLs0PnTDkFnl4ac3BBp+JhGvkDEbuYRhQjAI=;
        fh=VfWhaqxx+AkKmqUxqw2r+psqvd8OfMwbPiWnafMlLKE=;
        b=d8+u8hTHpcW/rb4HU75In73AYPBBCYJS2vWuTx2H891BaQxOJS5raS9bXYnvOE3yRq
         YAsbWXbPIIm422RBYR/aDDBSRi4qr7Vy36icNjl9zt1fNbsaCDgRLf23CUcIAPDdnQxp
         ze5Cv+CouppGUuDb4zokshOWZPH2i9/dJ65YYf92HD3LP0HDBoghMvJw4mJyBQ9+NyHA
         DqrfZdLRICo07zMqnAhsuKR4NhotoVTWjLqLwSTzhO1HFdflqOvwSfy7ts8j69eIeV92
         /DUmQBCoMIoeLvTu9hrupCvqcL2/tHA4BObgTEVflrQ74ytuk/IcIgIbYO1zoYjJGw+9
         0inA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786498586; x=1787103386; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TVVQmkJCLs0PnTDkFnl4ac3BBp+JhGvkDEbuYRhQjAI=;
        b=lCxmCTs932bLH89LNSxgQSOi/wC3LK3ajBKMbr/JaUJACjI8dojyajoaMrbQlUd7Ko
         U10mb+dYGlTp5xtlpcS+paw3BHBNnK7tQvdiASbIbMDimqCCTWIIciUfnA78iauyZ718
         3AniMGn8h5YbYnkRXLDebBqrPSVkHtCRSAZA+m+IPiiVtbzT38W6a6W8f8TAcwSAFcbk
         2bzgUF9jtnNtccJ3XN7a1i4LlvI2v4CXn6JhXZ95OBhrw45imL97wMqaTx58RNRoyMdd
         +aHVOvsmKbz26Jhmc9WPgokWUE/prTW0xtCh2ac6oMPqFZZnbB94IkiHA0bOqGOPSSbk
         RZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786498586; x=1787103386;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TVVQmkJCLs0PnTDkFnl4ac3BBp+JhGvkDEbuYRhQjAI=;
        b=ZEhuki66hkkWl2uhtoD5pNMMcO9skffKyfzPgN9lCQxqDHMWCNrHCkyUVI+cnUuUNj
         cYb27rscQJA/NFoACFXL9yJIlIKY10BSp5+bUvpTRs8yHfI3BsJUnAT1Q8LHmaHywD7w
         owIzHKrjNKloSnYYdXOHBF1ikHr6TOLg638zrQMW6syl5x7TPFvjvEpOocizsLLd7h2A
         aGWvMM1taaACh2a0utC7rbnCIQpkN5BCusQkze1c0biF5TlN4Mc7Abt/htpCBFtiL6Qh
         PamCWXejqVfVRwjyYs8iPeNAEb2Sj2WYtkkgBxkBxOcD4SBwqBGfxr+n/Ke5DVDzTK4T
         Exag==
X-Forwarded-Encrypted: i=1; AHgh+Rqwx5aAuEhyJOWegugCdKvw1ahwNJer19WwVx/JnJbgluJvS+zeWLd3DgMwgUD8/hys1QHl@lists.linux.dev
X-Gm-Message-State: AOJu0Yylf1TehAIhcyU8nh3/YWnhqjWP9jaV+lnZg6OdJn4IUJfGwXqR
	TRl323pGH6T+KEL2kmdxyUdUrmviIFBbTx2Kz1uf4S4xa7MVDNStTZ74VWbDqs04krKXDQhUXE3
	z95YoN1Rfsv+E6EsRwoGETAId8vyIWAw=
X-Gm-Gg: AR+sD10Wkq/H3mS2QHeCa9tXHd9c6/IpdZ0GFrCErcKGogrfk0RziCbfZoGLM/JLeNP
	RfGPUsEfW1x9W3XXswAE5p3CFsnNIRIizYaqtz3YPQUcLTrKKloQ59TO6xARSOUhT5BmOFcJBeu
	oNCioRgA1a3ZVmFPsOsGx60Pdkd8MR3Jv5eYSefnAi+MwTXPio4s2nwcL/ICG0eE3w1ux8OeY9T
	wssxx1Qv/t/Q3O+pzf5xaRh1MFz+Fp9IX5sy53S70UBDnFWtbYhNe4fkAy3yeeeV7xN0iKdwE5Z
	oBGcqQzWD9LI3JZ6cCKxto+yYkL72e9PFlDL7Qeem5nXyg==
X-Received: by 2002:a17:907:1c0f:b0:c19:6104:e5e4 with SMTP id
 a640c23a62f3a-c20f30471f3mr70249966b.20.1786498585955; Tue, 11 Aug 2026
 18:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANypQFasb8voDrg=O9xJikYHdRFeupb5VP2VeJaZ_wFNMoGr2Q@mail.gmail.com>
 <20260710092933.3631376-1-r772577952@gmail.com>
In-Reply-To: <20260710092933.3631376-1-r772577952@gmail.com>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Wed, 12 Aug 2026 09:35:49 +0800
X-Gm-Features: AUfX_mxkXfep7eCOgQBtqc4gdUTZ4WzEWreHsfgJ0xIiPQsyhH81XNHHtOH2IE4
Message-ID: <CANypQFbqXxxm4SC9OTc4t8N-pugheqQ3tXS+yOqg9gNzfvAhKQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: stop logd and quotad before kill_sb log flush
To: agruenba@redhat.com, gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jiaming Zhang <r772577952@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=8810=E6=
=97=A5=E5=91=A8=E4=BA=94 17:29=E5=86=99=E9=81=93=EF=BC=9A
>
> gfs2_kill_sb() issues a synchronous log flush before stopping the gfs2_lo=
gd and
> gfs2_quotad kthreads. Given a corrupted filesystem image, that flush can =
spend a
> long time while holding sd_log_flush_lock. Since the background threads a=
re
> still alive at that point, gfs2_logd can be woken and block on sd_log_flu=
sh_lock
> in gfs2_logd(), and gfs2_quotad can block on the same lock through
> gfs2_statfs_sync() -> __gfs2_trans_begin(). The threads can then remain i=
n
> uninterruptible sleep long enough to trigger the hung task.
>
> Stop the background threads before the kill_sb log flush. gfs2_destroy_th=
reads()
> waits for both kthreads to exit via kthread_stop_put(), so after it retur=
ns
> there is no live logd or quotad thread that can wait behind sd_log_flush_=
lock.
>
> Closes: https://lore.kernel.org/lkml/CANypQFasb8voDrg=3DO9xJikYHdRFeupb5V=
P2VeJaZ_wFNMoGr2Q@mail.gmail.com/
> Assisted-by: Codex:gpt-5.5-xhigh
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> ---
>  fs/gfs2/ops_fstype.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index 9b9e70f14d25..d087845a75d6 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -1776,6 +1776,8 @@ static void gfs2_kill_sb(struct super_block *sb)
>                 return;
>         }
>
> +       gfs2_destroy_threads(sdp);
> +
>         gfs2_log_flush(sdp, NULL, GFS2_LOG_HEAD_FLUSH_SYNC | GFS2_LFC_KIL=
L_SB);
>         dput(sdp->sd_root_dir);
>         dput(sdp->sd_master_dir);
> --
> 2.43.0
>

Friendly ping. Please let me know if there's anything you'd like me to chan=
ge.

Best Regards,
Jiaming Zhang
