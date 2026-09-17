Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6164256E055
	for <gfs2@lists.linux.dev>; Thu, 17 Sep 2026 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653902; cv=none; b=WwD4Nk4ZUi/mcF24gRehsd6NA+Z/V4ShONroyRLdQU1OJVLXUUY+nvjb2H5exNzhpiQtqjlM3BH0CSzviv9Vn8DySCcrWai/dDjM8+fppObYsuYpwZZVCFcJZkMc2cMJehYqAzlOWG/8hnpQyROK5Mkavnz1yJQ9p9hKh0Rp5ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653902; c=relaxed/simple;
	bh=Avy7am6+fJfuvUh+tazEtIBWfvo8Vd6W6MFK1TKmqBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wj4N3aAHUiBemvTkeQqFoOn0vovoShrpnTeWiZP/4TfTnfqKKaRNMaHgFwia/0MstsPAhu9ix05dWZXg9SooEmGzagX6nUQ8fnnGYa90BiIw78idtpeib6vR+24fylWUOJguYawndpeiA9wLceR5CRYBpEMCT2RWj3XUskhhHSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MHBMnrHy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHBMnrHy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789653900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xmJLfsTM6OFmtf48VTrfiGdKPLkz8C4K3G1aJXyW/j8=;
	b=MHBMnrHy44s2BbpTqpwLnIgwm4dys/r2hjsNnTqG5YO8TqZ+puHyv6yca7IQfWRw9W8vQh
	S7OolHR3wbLmTG8Nahoay2/TB7AqzC5hwW8L62BcuQVvd0SN4q8oQb5+jjkf9YB+SSJXsn
	viOJVnzsJPitg77RvnIdwWMEn7hLuk0=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-SZ0vRt_DP8O6L2HNu3ISWg-1; Thu, 17 Sep 2026 10:04:58 -0400
X-MC-Unique: SZ0vRt_DP8O6L2HNu3ISWg-1
X-Mimecast-MFC-AGG-ID: SZ0vRt_DP8O6L2HNu3ISWg_1789653897
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-66cdb701595so901426d50.1
        for <gfs2@lists.linux.dev>; Thu, 17 Sep 2026 07:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789653897; x=1790258697;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xmJLfsTM6OFmtf48VTrfiGdKPLkz8C4K3G1aJXyW/j8=;
        b=IkL3C3OBysibGyEJuZzmRhd39P1xasOzMdkbSIMRC4jAnFPC4TH0elA52sg33rIPv9
         IgVrtoGOcUIH/gVjJ//4KjQ4Kcn6k2u/wC+/7UmGSynEpFsD+T8W2c+DL/z0fN7jURau
         iBGTZ4FwXQGR4CDRcEF4TARjJHSSqq4MqFs9gFrOwqs5u1rkDmIISFaaLzGg51bLH6hf
         itc8K2QzHiqPl/mTCgeWvZK7zqYss68Kj/mH9IVljJ7qH1D1Id7khpj9C9T+9iZszlLS
         M3sjKa/hoKLe/fzHI//AngEoVZR6erJ+6c3AfOOmZ7cj+tbVj0uKavqaHPuMIW64ozx7
         nTmQ==
X-Gm-Message-State: AFuF++nKaBBQ/YAuLlUJDYT4Z6QyJwFyqjSUfoUWor6tV8azfk+vhxrF
	VIL2o77ZwMbjVKpgNjXoPtTj7LZpF2jk8VMoVJR6kTR+jVn4TeJsmuPJxWPApakIkHexxEl2gfS
	PqgDvPtxeeILLA2hx6SvvvZyC9CXBrKPXWCRgAqizPbdWA3n3Bi3wCEK+I+wpKYY3XqCNTZKYkf
	gire/fCk/THyKJskkXNZzQt3XycwEwpA==
X-Gm-Gg: AYBFou3e65C6rf9V03bQDiEvcRVowYKN0d3E1Nrn5yVnoJlxEXZ3PBZ8Sa1yUlM5JEn
	dzG4U0c1NISe2clKTCF+jJW7raFR67SvC+eo9glhv/zZqHbtw3bI/Pd3dZJHEXTQUU0pIVd0u6z
	Vhj8MnwSHQk0Sanb+DL57mPzwntTHdOV7aI7nunw2NyJirFsfvmbSAQEfBtYCTdg1Q6YZZE8qnM
	v2MfBsYaES78uyvO0u47zp6/Duo1btZiJ+d2jIv1VhrFA==
X-Received: by 2002:a53:c041:0:10b0:66e:6089:b3ab with SMTP id 956f58d0204a3-671632a39f1mr1668418d50.47.1789653897299;
        Thu, 17 Sep 2026 07:04:57 -0700 (PDT)
X-Received: by 2002:a53:c041:0:10b0:66e:6089:b3ab with SMTP id
 956f58d0204a3-671632a39f1mr1668404d50.47.1789653896745; Thu, 17 Sep 2026
 07:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAF9RqJ7jNhNNr1oYOeqpNiPGWEf0xWysz-D8N_yLVgmcJW17+Q@mail.gmail.com>
In-Reply-To: <CAF9RqJ7jNhNNr1oYOeqpNiPGWEf0xWysz-D8N_yLVgmcJW17+Q@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 17 Sep 2026 16:04:45 +0200
X-Gm-Features: AcwNN1VrJ3ziAQmlvBobZQJDGefBJ2CLQbI2G9TAapT1-hl9cKmYM1CK85MXZ5k
Message-ID: <CAHc6FU5mA_99pwAM7ARKBzOy0Zd2hYiX0VVJaZS-h-DxDDu7Zg@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix comment typos in lock_dlm.c
To: Ruslan Vagner <rusya92266@gmail.com>
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3OFL0CTttFO7KrZHYLSjBrXpTMpKNfJ7sZ23rCxwTgI_1789653897
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 2:56=E2=80=AFPM Ruslan Vagner <rusya92266@gmail.com=
> wrote:
> Fix the spelling in comments. No functional change.

This has already been fixed in for-next:

https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/=
?id=3D277536c882467e348173238e4ff701a4e4d2fb9e

Andreas

> Signed-off-by: Ruslan Vagner <rusya92266@gmail.com>
> ---
>  fs/gfs2/lock_dlm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
> index cef4bdee92a8..47eec0c13025 100644
> --- a/fs/gfs2/lock_dlm.c
> +++ b/fs/gfs2/lock_dlm.c
> @@ -431,7 +431,7 @@ static void gdlm_cancel(struct gfs2_glock *gl)
>   * 10. gfs2_control sets control_lock lvb =3D new gen + bits for failed =
jids
>   * 12. gfs2_recover does journal recoveries for failed jids identified a=
bove
>   * 14. gfs2_control clears control_lock lvb bits for recovered jids
> - * 15. gfs2_control checks if recover_block =3D=3D recover_start (step 3=
 occured
> + * 15. gfs2_control checks if recover_block =3D=3D recover_start (step 3=
 occurred
>   *     again) then do nothing, otherwise if recover_start > recover_bloc=
k
>   *     then clear BLOCK_LOCKS.
>   *
> @@ -809,7 +809,7 @@ static void gfs2_control_func(struct work_struct *wor=
k)
>
>         /*
>          * No more jid bits set in lvb, all recovery is done, unblock loc=
ks
> -        * (unless a new recover_prep callback has occured blocking locks
> +        * (unless a new recover_prep callback has occurred blocking lock=
s
>          * again while working above)
>          */
>
> --
> 2.54.0.windows.1
>

