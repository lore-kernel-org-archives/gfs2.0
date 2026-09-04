Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BED748164A
	for <gfs2@lists.linux.dev>; Fri,  4 Sep 2026 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525014; cv=none; b=iGfaVYteUj+6r7QKJXMHPT0C91FkogFqqqDSvFkqoIda2CcmeK70ok76WF/wYwPrY1mnjDJg9LaB7A6GL6rtF/hdFFnB7xAZPAVygcjgZr05N3acEdQrHpjnJRX0t0LkB84ehzOoMLBDDENN0bmuD6of3WKCCv1Hl3IEpxXxS28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525014; c=relaxed/simple;
	bh=I5BTR/HzEljtc2n+E1gWlsVC4e3Gg+56Gvfb2/y5hhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCYoUNxR0KWzyFO8cn+S8wH1YSw0iiNsKzrugoN51YwgWUMeNjbgqVP/k2PoKrQyRIO6+AChoHq0CTsxdyc+BX8wx4Jg76uHJB75O/mlcUnHjF9Mmsh/S2DLwXHauWsCjVyn+Pzpzvkm5ng0O+aNfyuvDAWLezTspJWm5rxjA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ROEdWHaP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROEdWHaP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788525010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XtgStQ72qjXy85OqcnWwLSAXMnFcnfmb4j7jwPWJOV0=;
	b=ROEdWHaPI4W8wHX3xpulT/o23YPuCj1FEPzgHjVM9G6kFdwmVOo37EaG+1PRnvN/oM4lLe
	bXebtC4tKfGwczp6SmWo/fS5T9nsTWDXuOtlOm0ZcTAsQFgzI79NZOLksDrafJAiK2Ofix
	y1d3kyaykqEdoI4etx3tje5M/MzSghU=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-WlTl3krTNQyH-NxDRQalTQ-1; Fri, 04 Sep 2026 08:30:09 -0400
X-MC-Unique: WlTl3krTNQyH-NxDRQalTQ-1
X-Mimecast-MFC-AGG-ID: WlTl3krTNQyH-NxDRQalTQ_1788525009
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66c7115a286so1072543d50.2
        for <gfs2@lists.linux.dev>; Fri, 04 Sep 2026 05:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525009; x=1789129809;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XtgStQ72qjXy85OqcnWwLSAXMnFcnfmb4j7jwPWJOV0=;
        b=sLfXp+9pHT4OsR+GFwnc+7ofe2A20896/uJQx0EUZu7P2DxZSkKn0xvPi6ql6fmiek
         HC1YaI0+2srDyJPF199lntijrm4vAb/udsbUdl5bramYqLIbVwWccxdk5awIPsQq3Kkc
         ZLq55Waz/mgdnhZGIEnU2sJs6IEk2ZKLoveaK/OFAnEjEypUHNd9qkgS4XxyLiR0vVeI
         GXR8afya+kmKWPTnD5f/Gocm+N/QzdLZIXwj4hpXdDJFQDBrBdVn3aMy3VxihpnAjHjC
         qnqzI0QZ3mYFw2V5gDQ3TAPfFPD6QsdVkReXwvSQ0PO3ETMor4P5JHhf79Xdt/FEZObf
         hneQ==
X-Forwarded-Encrypted: i=1; AKwUvBxcFHAZPlLkn3ii6VDgg5Z4cFOSi27dExV4KotyFFUwcSBSfvFQvIu5GpuydiWZJ4gPvEDN@lists.linux.dev
X-Gm-Message-State: AFuF++ke+bbgrpeHbnmeloEkDKrtOpo9q/DVCphIANmkGPdUyeY2d/U0
	s9as28dGc2qAqHVHQ0xZ7G/U8YIzIXaFPvyM6pzMaQ6/00uDv56Hy7riPVEOQds9GaKwQRSwzm/
	W++20KLR+i/7j+ojxRXLb/rfrsBYw+Q4h2oRQliWOhM2pq1KkjYiPauuDBOxCqwrgBdyNsykKKr
	3EOPqyw4NXV+E6PdIOeLV+HwtVlWWMtA==
X-Gm-Gg: AYBFou0M2gWAEeTsrIEp4RRESLL0eUg2G0w2tqFlmvqrFC8nCWZMAxtuSZoDvNKiV5r
	N3ZJlNlb7eQIGpCLZYTdWJBl6XqA2BsT/XGnriuRuOFZENAAJl0mQn+UpFzTQ5F5OKrHdcZ+egz
	FqMrmCncBjSggR504EG+KzbDK7tYj0Pb4n79Zff9qZAHs6czen7khj3wNa/IQ3n42UTfHrzBwE+
	VANMyXM41D/Oep1xmX9kYbGcs0cqq4gxg4Egrecopxx
X-Received: by 2002:a53:dd03:0:b0:66f:c1bc:c07b with SMTP id 956f58d0204a3-66fc1bccb91mr66224d50.67.1788525008566;
        Fri, 04 Sep 2026 05:30:08 -0700 (PDT)
X-Received: by 2002:a53:dd03:0:b0:66f:c1bc:c07b with SMTP id
 956f58d0204a3-66fc1bccb91mr66213d50.67.1788525007971; Fri, 04 Sep 2026
 05:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260904112429.39814-1-hemanth.selam@gmail.com>
In-Reply-To: <20260904112429.39814-1-hemanth.selam@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 4 Sep 2026 14:29:57 +0200
X-Gm-Features: AcwNN1UUnidSo_VDSIw3MRLX-0N_YQGsHOYA7b1CtjBhz2xIhMPaB_wEABGsBCc
Message-ID: <CAHc6FU43bc6Fawpst1G_MhUuN9itSpoj10qguKpeNsBHeOyDNQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix typos in comments
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S6Vc7QTExDIIBK6uiHeJZ6bEtY5Q-6eLdfHcjgktT0A_1788525009
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 1:24=E2=80=AFPM Hemanth Selam <hemanth.selam@gmail.c=
om> wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
>
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  fs/gfs2/bmap.c     | 2 +-
>  fs/gfs2/lock_dlm.c | 4 ++--
>  fs/gfs2/recovery.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 73c626971163..8c734450c998 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -1212,7 +1212,7 @@ const struct iomap_ops gfs2_iomap_ops =3D {
>   * @inode: The inode
>   * @lblock: The logical block number
>   * @bh_map: The bh to be mapped
> - * @create: True if its ok to alloc blocks to satify the request
> + * @create: True if its ok to alloc blocks to satisfy the request
>   *
>   * The size of the requested mapping is defined in bh_map->b_size.
>   *
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
> diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
> index 616c46aa3434..27777497677f 100644
> --- a/fs/gfs2/recovery.c
> +++ b/fs/gfs2/recovery.c
> @@ -155,7 +155,7 @@ int __get_log_header(struct gfs2_sbd *sdp, const stru=
ct gfs2_log_header *lh,
>   * @blk: the block to look at
>   * @head: the log header to return
>   *
> - * Read the log header for a given segement in a given journal.  Do a fe=
w
> + * Read the log header for a given segment in a given journal.  Do a few
>   * sanity checks on it.
>   *
>   * Returns: 0 on success,
> --
> 2.48.1

Applied to for-next, thanks.

Andreas

