Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793652104;
	b=ercQORD1kHhD7jCj+97XpaRwZAyK9q8eHwLXBqFpFL2FEagseooSI0IMjzbBSZOlsBc9
	 Ju0WIj3hv7sS5Eg2lyBkjQYbN/YpxXtrCGmSTa5mGs0+lRN8TnTgzak91BZcdOcHWWv0l
	 FBG4+FjU/RToqaKr4q5A+cmVdnvhgcP0QA1Po7tdA/tKRg8EyjyigDensnRTzR9bt/7jb
	 8v616wnVeWC2qcCTWBRLjlkjAoSpl/SRn6mMWsBhgihVQnWGv7ML2w9i2q5U6KdeNCxx1
	 XCZVXz/L54SrITZxNhdruQp7oCAAFVEIoT6smeq2LFiQDQhuRh/vn6Va15JubUVqqfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652104;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=pPfuhXuKj4uxJtVgdwO0y4Sg1BoFJPH2OXHo0IrP7P0=;
	b=pvT1cy9KHRsnfTR0IHgtXt/OfWkbuvhq8VrsZuOUqz2wSGtzcmiVjSrpCLg7bPmV8Evd
	 KsdLUb938l9i2Z7rbdXBNlYOhj2lGw7L+SX/UDKzkPAG6GKFnkILWQVHspOvxEdWv82Fs
	 gGFaFoB3uAWFT5xfkbK18HjK/5PrQLMr7rX/85he8Peq7yvSJYj1y2auIwFE61e6azBAE
	 f1xDV1Y1Mr+RQvDwcIihPkIb9qq8Iwiw8qwuEubTNzL3gLlaTgrze+0wQVplPWBE1I34S
	 CW4T+5On3pUXJbmgC63QuAH3/GZVTEcspKBZyF8mOqlueLHM7DdDSogyCcBjZSsyhfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U8O7AQDL;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD80F606A324
	for <gfs2@lists.linux.dev>; Mon,  2 Nov 2026 20:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD80F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U8O7AQDL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793652102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPfuhXuKj4uxJtVgdwO0y4Sg1BoFJPH2OXHo0IrP7P0=;
	b=U8O7AQDLY1PpUkWVWskOBsLg2fzmrCtvfpJb3eR8vu7Wc2nQJAvFdN3u4wJH7zLTaqvBcK
	w5fssyXVrFLH4tzRUfQhMrJqjrjuri/3eOtGKQlV/f5eBPNnMjbIYnNe+8+emYdolRlbKB
	1x/fuwwfoEmzGcaqky3q7T74/z+YdQo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-f7bxYoigMN-e0rtWL2P6fw-1; Mon, 02 Nov 2026 15:41:41 -0500
X-MC-Unique: f7bxYoigMN-e0rtWL2P6fw-1
X-Mimecast-MFC-AGG-ID: f7bxYoigMN-e0rtWL2P6fw_1793652100
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3ab3089df39so14621961fa.0
        for <gfs2@lists.linux.dev>; Mon, 02 Nov 2026 12:41:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793652100; x=1794256900;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pPfuhXuKj4uxJtVgdwO0y4Sg1BoFJPH2OXHo0IrP7P0=;
        b=BNVAHQU9RB7I6PPLWUaDo3jDEdeLCzq/s2MfrrQ/oXvlvpvI/IofGSWZhxF2B6rsGB
         oW0IVM1zPyXWXHVBw0fpF68rInyb6/qEuOGXXp3ZMSkZMxhuvLgRKN7KDHKtM8qS3RW6
         lSUPm/m1ctvUjoLu1Laga4MgV7Ih/je0Wd1+yuta6KYYgm4A5F7kzd3mki5nDxY1vs8m
         o6cr8rYUk+UpbW4t6Pe5KThEQ2ZZMUS5LUW0qxF2Ckc2JwNs0q6ucPhND1h5u1OZsFwz
         vJVzpiTV+7MKgXRzVSUUYvVqT7jc6AFDYxH4RnGa494nqFKyAlYxo9aAOeBlnTSBRg4w
         1VGg==
X-Forwarded-Encrypted: i=1; AKwUvBwwjJw0H9JJwf5gxp+bZzdHtKnO72koteZuGaiG7a+8hNWJ9jzWhj8KQn1tZqC6VFa2BYf9@lists.linux.dev
X-Gm-Message-State: APuU4Z9fJL9VpEeCbJ4gKBuzBLeQgbKyurFiTGR6ubbacRGD57Lel81h
	h8pvOwU7DGX8FECqe7e4PmkyOqC5gBY7B9Su7gEPk1+avJbMl86qQPqYPxbJSBOYAlFoG4FdZrt
	g3ZpmgXMj6ntyUVy5+pL69fSpkdLvX0lbFBOb7Mr0D0JgN/iJUKdDLjzCthBRoGljTuqk3+MS1n
	N8ovLdfXrJSW7kmJ7RC958r39qRqQk2A==
X-Gm-Gg: AYBFou1KWOUgOibVwHmi0HlnJAKbLOz7tGOp41YtLFqPm/cL75ffMNE009IC9PajKGT
	tq0HBt/65+erp48WrNf8ZknqVJps8/5uD2jL5CDgb2PETf9n4td/IB1xYmiyqYitefxfl5AKQ6W
	2BbNyraocfAradpy9snKuAHJOs09fbjWPeuo+5kb5Ukhp85y/+Y2BPbHfD
X-Received: by 2002:a05:651c:150a:b0:3a9:8167:62a with SMTP id 38308e7fff4ca-3acb7b6498emr30604661fa.28.1793652099939;
        Mon, 02 Nov 2026 12:41:39 -0800 (PST)
X-Received: by 2002:a05:651c:150a:b0:3a9:8167:62a with SMTP id
 38308e7fff4ca-3acb7b6498emr30604611fa.28.1793652099559; Mon, 02 Nov 2026
 12:41:39 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261019184849.24422-1-sanan.hasanou@gmail.com>
In-Reply-To: <20261019184849.24422-1-sanan.hasanou@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 2 Nov 2026 15:41:27 -0500
X-Gm-Features: AclHuK8WVNVvU2rcm4KZuGFkSSfZ2u0smM4kgrswPda8flMMQv9IN77de7FcSJo
Message-ID: <CAK-6q+gvq=y+P+wmUTGWJcNRLP1Hjw_W=i_rwuvVhpS0d+h6Og@mail.gmail.com>
Subject: Re: [PATCH] dlm: don't put an uninitialized lockspace kobject on error
To: Sanan Hasanov <sanan.hasanou@gmail.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+b2b8d04ec4914f618d23@syzkaller.appspotmail.com, 
	Sanan Hasanov <sanan.hasanov@ucf.edu>, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e3i2W4gFK-DT92M5SPcrFM_eiDjJhUZLvSoJMr8D0aM_1793652100
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 19, 2026 at 2:49=E2=80=AFPM Sanan Hasanov <sanan.hasanou@gmail.=
com> wrote:
>
> From: Sanan Hasanov <sanan.hasanov@ucf.edu>
>
> Commit 8a4cf500f1dd ("dlm: drop kobject release callback handling")
> dropped the do_unreg flag from new_lockspace() and made the out_lsfree
> error label call kobject_put(&ls->ls_kobj) unconditionally. But ls_kobj
> is only initialized by kobject_init_and_add() after the callback
> workqueue and dlm_recoverd have been started, so every failure before
> that point puts a kobject that was never initialized:
>
>   dlm: ls_6035_1: can't start dlm_callback -12
>   kobject: '(null)' (ffff888027a28088): is not initialized, yet kobject_p=
ut() is being called.
>   WARNING: lib/kobject.c:736 at kobject_put+0x66/0x550 lib/kobject.c:734
>   Call Trace:
>    new_lockspace fs/dlm/lockspace.c:617 [inline]
>    __dlm_new_lockspace+0x1714/0x1cd0 fs/dlm/lockspace.c:638
>    device_create_lockspace+0xc7/0x350 fs/dlm/user.c:414
>    device_write+0x872/0xed0 fs/dlm/user.c:606
>    vfs_write+0x296/0xba0 fs/read_write.c:685
>
> syzbot hits this by sending SIGKILL to a task creating a lockspace
> through /dev/dlm-control, so that alloc_ordered_workqueue() in
> dlm_callback_start() fails to create its rescuer thread. The same
> happens if rhashtable_init(), the ls_recover_buf allocation or
> dlm_recoverd_start() fail.
>
> Bring the flag back so the kobject is only put once
> kobject_init_and_add() has been called. Since the kobject no longer
> frees the lockspace, kfree(ls) still runs on every error path.
>
> Fixes: 8a4cf500f1dd ("dlm: drop kobject release callback handling")
> Reported-by: syzbot+b2b8d04ec4914f618d23@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Db2b8d04ec4914f618d23
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanan Hasanov <sanan.hasanov@ucf.edu>

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks.

This patch conflicts with another patch that is probably not going
through the dlm tree. It will not fix this issue [0]

I think it's best to wait and queue your fix until it's through, and
then we can rebase your patch.

- Alex

[0] https://lore.kernel.org/gfs2/20261027223847.652884-6-irogers@google.com=
/

