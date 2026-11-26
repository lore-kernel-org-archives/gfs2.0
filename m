Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686583;
	b=1YA491xawrrGpeCYr2n6jkFH50Z5UpxrPa9vQfhjIwsdkm8VwUKKlpZAl+eWTTH1y0S9
	 esRj9r9T/WWDSWJfrO+ZObrTO2jj2geYzaFsQMzqySxX9bOLfWt1nUOMYdU5AVRDkbhQE
	 aaVqa8xZChGDlfzD1SuhbPPOChC06vLgx/w8FG9x6rAdlLI6b88/d8GG2XCKZeUwTbpVk
	 2KjL72gbgEvSuZxMwODfseXvO6uTG/2ri2pGTnYpRhr3G57gpXyUXNwGdE3vVMMVk6yG3
	 SJ16GGvhxV6HDdrHv9Wh08OsRmu13MN5M9RE1qWdGUdc7WMUntR6vJaKaqlr99QLe3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686583;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type;
	bh=GNrgKTXTrOFzDhPgeYf03Ncje4wZ/Zh1NZKNX0O4g38=;
	b=UokIug+BGNm774zzFvMx3Y8O0GpxoaSahMWy1JsiWv9eNY4gEmfaBREdXqxE0iLLjO6Z
	 jwehd+HJjn80BO9JuwPlzIvkApw764SOZFD89jht8UfdpgrRQG1i9q6pDcUWjbMEj+y5A
	 WMi/iv84VPYK4x+EEqUBS9klj65IuhjOFvtpG9J1bgMhwElxraqyeq3WDFkqJRR4Nqjuf
	 AL2wwZ9gxv/JCTDB+HIs8IkeQgFpJ9d3h92NltpRTlOBCrzLSnnJIo+6eSxxHtkPvJM06
	 d9rUo79bklEL/GJETGe1TXCMwWFLf4U77LDy/g/Csw7AqLUuwA4eotgJMKAwU7oLouA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hZ2xBB7A;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C945B606A329
	for <gfs2@lists.linux.dev>; Thu, 26 Nov 2026 09:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C945B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hZ2xBB7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795686581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GNrgKTXTrOFzDhPgeYf03Ncje4wZ/Zh1NZKNX0O4g38=;
	b=hZ2xBB7Azv4omwSVIkM/Hh2GyVCm7IS8p21DXChB3JScwkpPULY/hAYd25WfljkqE/xyKB
	bNFRa2ViFr/gNwmnc8Hed958J0ZURHqHHo5S4CNIOm4og3TEplUt8+ix6+2HwjijxfmzqC
	2Wl+iQ0RQhw+Akja/GRnWNujqDmHsgs=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-h66TUj60Mtun19InJzOEIg-1; Thu, 26 Nov 2026 09:49:39 +0000
X-MC-Unique: h66TUj60Mtun19InJzOEIg-1
X-Mimecast-MFC-AGG-ID: h66TUj60Mtun19InJzOEIg_1795686579
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b4dca1ef03so81295887b3.2
        for <gfs2@lists.linux.dev>; Thu, 26 Nov 2026 01:49:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795686579; x=1796291379;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GNrgKTXTrOFzDhPgeYf03Ncje4wZ/Zh1NZKNX0O4g38=;
        b=Hv1++Buh0XkAjrBK0vtx3SPo+xdT5njxdHUc3Deu31JPgp768jnoLBFjVlls+kgCcu
         jw1Pu78klQpblEHep3wH1VXCX2NWv1Uyc4OQMkVhNMmgfNivvCCTdYNFETjdeWFGTJTR
         JZVOMRR9dmjQxKBLz1klxr3jIhVO5YXgLDM35M887eGY7Njp63ndyQuT/OoSEnbm/qf+
         uqRwsqtyY2k9yLRUF0OS57lKQ1/dSUMmXErrXekf/htt0Jl75S/egzYuPklrFTZebz5P
         Hgb7VEeD0OpQmDijkGvPwNiHp+oXoAGIgzij1bnzz+xTUPbL9iD3z3GrwHzKLEsppY5Z
         zFtA==
X-Gm-Message-State: APuU4Z89u1A1nPze+xgeZArQg4gnza0c6hQ9rzjcIrtFr6WLy0ZNm716
	aXQL+CPw0mQ3rUGtiDcRy41cXGm9s3fcey3PJZTs6aMG1oiwr07nlK+Wqewyjow+cb0TbzZV1kN
	M1G+h0T9JMLWmfXZV1DokMDWyOR2M8+r4K//C/+QWHBQiqN2g5b/egd1LjOnDpilCUJ6Lg5RAK7
	Z/NECWyxWtrDzd2avv+1jVwi/sSMOMOg==
X-Gm-Gg: AZFdTZfbUPFYRdV61JuAdJKJgiwyTKgZ0GKCBv975kd0CdShQiNHQ2tFw4vxXPFhe1I
	iN4eECIhvZf43cm+Ca61CDWqnKkRuRgU/5vSnoSWtSOrXAOe2hkKhnX/1vO3gFpL0X11okW/ecd
	cC8WwDx2uJLGT39DAz1rCRnzTPHHMlOyAV305xrwhi3m0poTqACS2ptiBcHDnP3wmkd1JvijoeE
	x2zVKNu18r1Yr1m654dCDs/BHxnDl9q7QFvVEGkZITAbg==
X-Received: by 2002:a05:690c:9986:b0:8b4:c71b:e4d6 with SMTP id 00721157ae682-8b5204b4e2dmr82175047b3.35.1795686579035;
        Thu, 26 Nov 2026 01:49:39 -0800 (PST)
X-Received: by 2002:a05:690c:9986:b0:8b4:c71b:e4d6 with SMTP id
 00721157ae682-8b5204b4e2dmr82174937b3.35.1795686578546; Thu, 26 Nov 2026
 01:49:38 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261125175007.3659558-1-hengyul@cs.unc.edu> <20261125185332.2549812-1-agruenba@redhat.com>
 <20261126032826.4156477-1-hengyul@cs.unc.edu>
In-Reply-To: <20261126032826.4156477-1-hengyul@cs.unc.edu>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 26 Nov 2026 10:49:26 +0100
X-Gm-Features: Aa3M54pOdvxu5XUY1DJw0M0cDCzeBZYAQTrBCHj1-4qHVGgpDIiPEkW5-yGupmc
Message-ID: <CAHc6FU7MnFrA8E6OyvOk8WwiiozCT4=QPjne7ftoLq_n7dOmYw@mail.gmail.com>
Subject: Re: [PATCH] gfs2: restart rename when a signal interrupts the glock wait
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yk6hy0ZfUDL7XPE-oYuVirW5bjSft9TEOOvWrLprh-s_1795686579
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Nov 2026 at 04:28, Hengyu Liang <hengyul@cs.unc.edu> wrote:
> Hi Andreas,
>
> On Wed, 25 Nov 2026 at 19:53, Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > Why not make gfs2_glock_async_wait() non-interruptible instead?
> > Something like the below should work.
>
> That is better, thanks.
>
> There is one problem in the sketch:
>
> >                       prepare_to_wait(waitq[i], wait + i, TASK_INTERRUPTIBLE);
> >               if (!glocks_pending(num_gh, ghs))
> >                       break;
> > -             if (signal_pending(current)) {
> > +             ret = schedule_timeout_killable(ret);
>
> schedule_timeout_killable() sets the task state to TASK_KILLABLE again
> after glocks_pending() has been checked. If the last pending glock is
> granted between the check and that point, the wakeup sets the task to
> TASK_RUNNING and removes the wait entry, and then the state is
> overwritten. The task then sleeps until the timeout expires. It does
> not hang, but the rename waits for the rest of the timeout.
>
> I would pass TASK_KILLABLE to prepare_to_wait() and keep
> schedule_timeout():
>
>         for (;;) {
>                 for (i = 0; i < num_gh; i++)
>                         prepare_to_wait(waitq[i], wait + i, TASK_KILLABLE);
>                 if (!glocks_pending(num_gh, ghs))
>                         break;
>                 if (fatal_signal_pending(current)) {
>                         ret = -EINTR;
>                         break;
>                 }
>                 ret = schedule_timeout(ret);
>                 if (!glocks_pending(num_gh, ghs))
>                         break;
>                 if (!ret) {
>                         ret = -ESTALE; /* request timed out. */
>                         break;
>                 }
>         }
>
> The back-off sleep would be schedule_timeout_killable() followed by
> fatal_signal_pending(), as in your sketch.
>
> I tested this version on gfs2 for-next with lock_nolock, KASAN and
> lockdep. The mv reproducer from the patch moves all 12000 files, and no
> rename fails with EINTR under SA_RESTART handlers, handlers without
> SA_RESTART, or stop / continue. SIGKILL and SIGTERM still end a rename,
> and fsck.gfs2 is clean afterwards.
>
> If that is fine with you, I will send a v2 like this with your
> Suggested-by.

Yes, that sounds good.

Thanks,
Andreas

