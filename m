Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795133319;
	b=ItBqNNtRifiy9WzYxBfpB/tKHSlk4DPoXgK0T7HcePw1qjVTZf0yR3BT5IpZpgG0wtcH
	 XGzTxS3akimIulo0JAwbX7CHgSMe+LZIdhOHVlrFmVRWRdoO/68rt3YGhBK2lytBTDc1E
	 1Vnx7X50/yA0xhMZNycDrVL1wNHiKYEAqepfOh5L4GMsELbG9OD6AKXDxhWn0YicCHzkd
	 /DLI/RczOVX648HK1l5DIwaCPIi8PqxNPHbtFiEQ8linQMkBn8szsngcD4MuvRnRud3Ar
	 9FM80tx5AS1Uav5znBZIVicK/oc5sc4smhXtZn3za/51j73mWfqcUQLOBdN0gymRauw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133319;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Transfer-Encoding;
	bh=tZlU1z7BvdYlkvDEf1eTGX15VRLDW9lspJV4MixYjmA=;
	b=tbtcQ3hdGTufjuFx+Q7f7DmOQtv1E8sy6koXGr8srIBtKHle9RvkOWfdrLehow8O/IX7
	 5MS4Wq6KHssCADdHj3q9Pz7t9PgPhXRQZlS6W6vT85O+d+I2gIDFuFPugSnJWNgYh/gMP
	 ZP7B1LUl+d63lISJbP+7Qzz6w5y3GyxLC7k6QoihU4d2qtPFf14OJTVlHjBHzUoKoctlD
	 UIb1rLgD/LiF+oIQkk8rJVpB06Rp7+YGjjQFADzQSHd/qWEBeu7AaXPj4XA0agUxpGYK+
	 ObfZ3TPTwRWEMb1XpBkJexsqyf25YXtbug/MCkWWsh8MUtk3hez2gIBfW9ZOPv664hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fAdcXQEv;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D3C606A761
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 00:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30D3C606A761
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fAdcXQEv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795133317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tZlU1z7BvdYlkvDEf1eTGX15VRLDW9lspJV4MixYjmA=;
	b=fAdcXQEvxpW5xd/l5IChlfcoMhXM8FhWgDMegBaR6g+mraokr9hjhNjAiKX+OVv4KI2l3k
	1dB2HertdwhTpDptRccwgJhJKdsOhhd6lZ/E37YkaO1yzALO+taUEPxMSuIAccqztn/zEu
	UW3wu/Hwfk/Pt3hUxpIjCzC75a1ip0A=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-mcxrvf_7P3CBav9WDQNc6g-1; Fri, 20 Nov 2026 00:08:35 +0000
X-MC-Unique: mcxrvf_7P3CBav9WDQNc6g-1
X-Mimecast-MFC-AGG-ID: mcxrvf_7P3CBav9WDQNc6g_1795133315
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b0f1c06332so6379847b3.3
        for <gfs2@lists.linux.dev>; Thu, 19 Nov 2026 16:08:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795133315; x=1795738115;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tZlU1z7BvdYlkvDEf1eTGX15VRLDW9lspJV4MixYjmA=;
        b=Sg/fcg6Kf+sk4SYYvJa2NA/vUYjVRLBegZXzqQxd3m8YhrYOFVEE5YCdsJ+P4l9qeH
         xEAfZ22CriwSK/nBhm/zYEa+JWU7Yj5x2V7UBDsNGhrVCgJh1Uf4VPGam6busla0SmY0
         3mUw5bbptP+HlGkj2eJ1TFkuEdCS96cecuC8kEjMIRjRMYDdRCV4uvUfNwOYT7MnDN06
         2N9w42ZqXusT6QwrdEFtRB7p8gfP3PieyC0o9Z4ha8xp7glWGah/5hjbBH1mqRBY4NOU
         uLuMFbbSzVl5Ix2cdAMpvQpt9aei85FbwnA7e/whPnK6osRJaCBiGEvT+qEl6knds6IT
         EZMg==
X-Gm-Message-State: APuU4Z9z+cl0H0fsqf+TuwF+XlKAnpv22EeOvG0jhDe3M00Rmzsmtciy
	PfX1XZ+90Reayv6Gan6zYq8/hoyqygKOmFSX6IhBZRnu5nkSmcq9+VWo2qje2RDiYLPZk0JDCr5
	F1sBP4/hU2+nwyP2TZrEfvwLHBTuqEP4m3RwTZspnMpKhKaTIbmbiJNgQDs77RTT5eDKrOi56mV
	+P/ADDmHFr2HMJTHet0PoIaq1ogT74hQ==
X-Gm-Gg: AZFdTZcxuiW4Y1U/uHtJ1t/eFbUnGySxDnKSZrm6W0bqP7rAtBXZRkLZW5+RtEEaj8l
	rz3IHp5DyBuHvsbReWmnv60is5+cwpZt63AWFXOxvAPbphhdOoGU5DMtNCMXaLVMuGepLTZFgGr
	uhJUGNzqnlm2ykJuAhvAmM0P3VVsur7dksoYBu8uQHJ9tE27/Ruk90Wohtw9YwPOX+pL17eT1Oc
	3/AJubXZmij1OGPTKs4ABP7Fl4qWjzuK95qtoEi0cXfVA==
X-Received: by 2002:a05:690e:4395:b0:67d:a676:2623 with SMTP id 956f58d0204a3-67df448cf8fmr314622d50.98.1795133314371;
        Thu, 19 Nov 2026 16:08:34 -0800 (PST)
X-Received: by 2002:a05:690e:4395:b0:67d:a676:2623 with SMTP id
 956f58d0204a3-67df448cf8fmr314611d50.98.1795133313538; Thu, 19 Nov 2026
 16:08:33 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261117-gfs2-log-folio-v1-0-35db3db42e35@columbia.edu> <20261117-gfs2-log-folio-v1-1-35db3db42e35@columbia.edu>
In-Reply-To: <20261117-gfs2-log-folio-v1-1-35db3db42e35@columbia.edu>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 20 Nov 2026 01:08:21 +0100
X-Gm-Features: AclHuK_h6M8Sg0EUxLC-P37DvIaDVLIcg84ZcaN743Bo5EOV0k4K3CKHe4suvks
Message-ID: <CAHc6FU7adAS0f2BjU6iU3AUD6hAFF=2zOeCMkVvV88p4O-a6=w@mail.gmail.com>
Subject: Re: [PATCH 1/3] gfs2: stop using pages for log buffers
To: Tal Zussman <tz2294@columbia.edu>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zY8d444Yx0mSVrl2pUGULE7GqwvmryTFVW66-GFayDg_1795133315
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 8:46=E2=80=AFAM Tal Zussman <tz2294@columbia.edu> w=
rote:
>
> The log headers, descriptors, revoke blocks, and escaped block copies
> come from a mempool of pages and share a bio with the buffer heads being
> journaled. The completion handler tells the two apart by checking each
> segment for buffers, which treats a pool page as a folio. That won't
> work once memdescs give these pages a type of their own.
>
> Allocate them from a kmalloc mempool instead and add them to the bio
> with bio_add_virt_nofail(). Give the pool blocks their own completion
> handler, and start a new bio whenever the handler changes so that a bio
> only holds one kind of segment. gfs2_log_write() now takes a folio, so
> the log write path no longer uses struct page.
>
> Each descriptor and each escaped block copy is now a bio of its own.
> They are contiguous and merge under an I/O scheduler, but the flush
> path doesn't plug, so without a scheduler they reach the device as
> separate writes.
>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  fs/gfs2/log.c  |  10 ++-
>  fs/gfs2/lops.c | 203 +++++++++++++++++++++++++++++++++++----------------=
------
>  fs/gfs2/lops.h |   6 +-
>  fs/gfs2/main.c |   8 +--
>  fs/gfs2/util.c |   2 +-
>  fs/gfs2/util.h |   2 +-
>  6 files changed, 139 insertions(+), 92 deletions(-)
>
> diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
> index 1baaaf30c4fa..238f6655e15f 100644
> --- a/fs/gfs2/log.c
> +++ b/fs/gfs2/log.c
> @@ -841,7 +841,6 @@ void gfs2_write_log_header(struct gfs2_sbd *sdp, stru=
ct gfs2_jdesc *jd,
>  {
>         struct gfs2_log_header *lh;
>         u32 hash, crc;
> -       struct page *page;
>         struct gfs2_statfs_change_host *l_sc =3D &sdp->sd_statfs_local;
>         struct timespec64 tv;
>         struct super_block *sb =3D sdp->sd_vfs;
> @@ -850,9 +849,8 @@ void gfs2_write_log_header(struct gfs2_sbd *sdp, stru=
ct gfs2_jdesc *jd,
>         if (gfs2_withdrawn(sdp))
>                 return;
>
> -       page =3D mempool_alloc(gfs2_page_pool, GFP_NOIO);
> -       lh =3D page_address(page);
> -       clear_page(lh);
> +       lh =3D mempool_alloc(gfs2_log_buf_pool, GFP_NOIO);
> +       memset(lh, 0, sb->s_blocksize);
>
>         lh->lh_header.mh_magic =3D cpu_to_be32(GFS2_MAGIC);
>         lh->lh_header.mh_type =3D cpu_to_be32(GFS2_METATYPE_LH);
> @@ -905,8 +903,8 @@ void gfs2_write_log_header(struct gfs2_sbd *sdp, stru=
ct gfs2_jdesc *jd,
>                      sb->s_blocksize - LH_V1_SIZE - 4);
>         lh->lh_crc =3D cpu_to_be32(crc);
>
> -       gfs2_log_write(sdp, jd, page, sb->s_blocksize, 0, dblock,
> -                      REQ_OP_WRITE | op_flags);
> +       gfs2_log_write_buf(sdp, jd, lh, sb->s_blocksize, dblock,
> +                          REQ_OP_WRITE | op_flags);
>         gfs2_log_submit_write(&jd->jd_log_bio);
>  }
>
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 657edd406dd1..c86f92f2e508 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -196,45 +196,69 @@ static void gfs2_end_log_write_bh(struct gfs2_sbd *=
sdp, struct folio *folio,
>         } while (bh && size);
>  }
>
> +static void gfs2_log_write_error(struct bio *bio)
> +{
> +       struct gfs2_sbd *sdp =3D bio->bi_private;
> +       int err =3D blk_status_to_errno(bio->bi_status);
> +
> +       if (!cmpxchg(&sdp->sd_log_error, 0, err))
> +               fs_err(sdp, "Error %d writing to journal, jid=3D%u\n",
> +                      err, sdp->sd_jdesc->jd_jid);
> +       gfs2_withdraw(sdp);
> +}
> +
> +static void gfs2_log_write_done(struct bio *bio)
> +{
> +       struct gfs2_sbd *sdp =3D bio->bi_private;
> +
> +       bio_put(bio);
> +       if (atomic_dec_and_test(&sdp->sd_log_in_flight))
> +               wake_up(&sdp->sd_log_flush_wait);
> +}
> +
>  /**
> - * gfs2_end_log_write - end of i/o to the log
> + * gfs2_end_log_write - end of I/O to the log for buffers
>   * @bio: The bio
>   *
> - * Each bio_vec contains either data from the pagecache or data
> - * relating to the log itself. Here we iterate over the bio_vec
> - * array, processing both kinds of data.
> - *
> + * Every folio in the bio comes from the page cache. Unlock the buffers
> + * that were written.
>   */
>
>  static void gfs2_end_log_write(struct bio *bio)
>  {
>         struct gfs2_sbd *sdp =3D bio->bi_private;
> -       struct bio_vec *bvec;
> -       struct bvec_iter_all iter_all;
> +       struct folio_iter fi;
>
> -       if (bio->bi_status) {
> -               int err =3D blk_status_to_errno(bio->bi_status);
> +       if (bio->bi_status)
> +               gfs2_log_write_error(bio);
>
> -               if (!cmpxchg(&sdp->sd_log_error, 0, err))
> -                       fs_err(sdp, "Error %d writing to journal, jid=3D%=
u\n",
> -                              err, sdp->sd_jdesc->jd_jid);
> -               gfs2_withdraw(sdp);
> -       }
> +       bio_for_each_folio_all(fi, bio)
> +               gfs2_end_log_write_bh(sdp, fi.folio, fi.offset, fi.length=
,
> +                                     bio->bi_status);
>
> -       bio_for_each_segment_all(bvec, bio, iter_all) {
> -               struct page *page =3D bvec->bv_page;
> -               struct folio *folio =3D page_folio(page);
> +       gfs2_log_write_done(bio);
> +}
>
> -               if (folio && folio_buffers(folio))
> -                       gfs2_end_log_write_bh(sdp, folio, bvec->bv_offset=
,
> -                                       bvec->bv_len, bio->bi_status);
> -               else
> -                       mempool_free(page, gfs2_page_pool);
> -       }
> +/**
> + * gfs2_end_log_write_buf - end of I/O to the log for log blocks
> + * @bio: The bio
> + *
> + * Every segment in the bio is a block from the log buffer mempool.
> + * Return them to the pool.
> + */
>
> -       bio_put(bio);
> -       if (atomic_dec_and_test(&sdp->sd_log_in_flight))
> -               wake_up(&sdp->sd_log_flush_wait);
> +static void gfs2_end_log_write_buf(struct bio *bio)
> +{
> +       struct bio_vec *bvec;
> +       struct bvec_iter_all iter_all;
> +
> +       if (bio->bi_status)
> +               gfs2_log_write_error(bio);
> +
> +       bio_for_each_segment_all(bvec, bio, iter_all)
> +               mempool_free(bvec_virt(bvec), gfs2_log_buf_pool);
> +
> +       gfs2_log_write_done(bio);
>  }
>
>  /**
> @@ -291,9 +315,9 @@ static struct bio *gfs2_log_alloc_bio(struct gfs2_sbd=
 *sdp, u64 blkno,
>   * @flush: Always flush the current bio and allocate a new one?
>   *
>   * If there is a cached bio, then if the next block number is sequential
> - * with the previous one, return it, otherwise flush the bio to the
> - * device. If there is no cached bio, or we just flushed it, then
> - * allocate a new one.
> + * with the previous one and the bio has the same completion handler,
> + * return it, otherwise flush the bio to the device. If there is no
> + * cached bio, or we just flushed it, then allocate a new one.
>   *
>   * Returns: The bio to use for log writes
>   */
> @@ -309,7 +333,7 @@ static struct bio *gfs2_log_get_bio(struct gfs2_sbd *=
sdp, u64 blkno,
>
>                 nblk =3D bio_end_sector(bio);
>                 nblk >>=3D sdp->sd_fsb2bb_shift;
> -               if (blkno =3D=3D nblk && !flush)
> +               if (blkno =3D=3D nblk && bio->bi_end_io =3D=3D end_io && =
!flush)
>                         return bio;
>                 gfs2_log_submit_write(biop);
>         }
> @@ -319,38 +343,63 @@ static struct bio *gfs2_log_get_bio(struct gfs2_sbd=
 *sdp, u64 blkno,
>  }
>
>  /**
> - * gfs2_log_write - write to log
> + * gfs2_log_write - write a folio segment to the log
>   * @sdp: the filesystem
>   * @jd: The journal descriptor
> - * @page: the page to write
> + * @folio: the folio to write
>   * @size: the size of the data to write
> - * @offset: the offset within the page
> + * @offset: the offset within the folio
>   * @blkno: block number of the log entry
>   * @opf: REQ_OP | op_flags
>   *
> - * Try and add the page segment to the current bio. If that fails,
> + * Try and add the folio segment to the current bio. If that fails,
>   * submit the current bio to the device and create a new one, and
> - * then add the page segment to that.
> + * then add the folio segment to that.
>   */
>
> -void gfs2_log_write(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
> -                   struct page *page, unsigned size, unsigned offset,
> -                   u64 blkno, blk_opf_t opf)
> +static void gfs2_log_write(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
> +                          struct folio *folio, unsigned int size,
> +                          unsigned int offset, u64 blkno, blk_opf_t opf)
>  {
>         struct bio *bio;
> -       int ret;
>
>         bio =3D gfs2_log_get_bio(sdp, blkno, &jd->jd_log_bio, opf,
>                                gfs2_end_log_write, false);
> -       ret =3D bio_add_page(bio, page, size, offset);
> -       if (ret =3D=3D 0) {
> +       if (!bio_add_folio(bio, folio, size, offset)) {
>                 bio =3D gfs2_log_get_bio(sdp, blkno, &jd->jd_log_bio,
>                                        opf, gfs2_end_log_write, true);
> -               ret =3D bio_add_page(bio, page, size, offset);
> -               WARN_ON(ret =3D=3D 0);
> +               WARN_ON(!bio_add_folio(bio, folio, size, offset));
>         }
>  }
>
> +/**
> + * gfs2_log_write_buf - write a log buffer to the log
> + * @sdp: the filesystem
> + * @jd: The journal descriptor
> + * @buf: the buffer to write, from the log buffer mempool
> + * @size: the size of the data to write
> + * @blkno: block number of the log entry
> + * @opf: REQ_OP | op_flags
> + *
> + * Like gfs2_log_write(), for a block allocated from gfs2_log_buf_pool.
> + * Ownership of the buffer passes to the bio, which returns it to the
> + * pool on completion.
> + */
> +
> +void gfs2_log_write_buf(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
> +                       void *buf, unsigned int size, u64 blkno,
> +                       blk_opf_t opf)
> +{
> +       struct bio *bio;
> +
> +       bio =3D gfs2_log_get_bio(sdp, blkno, &jd->jd_log_bio, opf,
> +                              gfs2_end_log_write_buf, false);
> +       if (bio->bi_vcnt >=3D bio->bi_max_vecs)
> +               bio =3D gfs2_log_get_bio(sdp, blkno, &jd->jd_log_bio,
> +                                      opf, gfs2_end_log_write_buf, true)=
;
> +       bio_add_virt_nofail(bio, buf, size);
> +}
> +
>  /**
>   * gfs2_log_write_bh - write a buffer's content to the log
>   * @sdp: The super block
> @@ -367,30 +416,30 @@ static void gfs2_log_write_bh(struct gfs2_sbd *sdp,=
 struct buffer_head *bh)
>
>         dblock =3D gfs2_log_bmap(sdp->sd_jdesc, sdp->sd_log_flush_head);
>         gfs2_log_incr_head(sdp);
> -       gfs2_log_write(sdp, sdp->sd_jdesc, folio_page(bh->b_folio, 0),
> -                       bh->b_size, bh_offset(bh), dblock, REQ_OP_WRITE);
> +       gfs2_log_write(sdp, sdp->sd_jdesc, bh->b_folio, bh->b_size,
> +                      bh_offset(bh), dblock, REQ_OP_WRITE);
>  }
>
>  /**
> - * gfs2_log_write_page - write one block stored in a page, into the log
> + * gfs2_log_write_block - write one block stored in a log buffer, into t=
he log
>   * @sdp: The superblock
> - * @page: The struct page
> + * @buf: The buffer
>   *
> - * This writes the first block-sized part of the page into the log. Note
> - * that the page must have been allocated from the gfs2_page_pool mempoo=
l
> - * and that after this has been called, ownership has been transferred a=
nd
> - * the page may be freed at any time.
> + * This writes the first block-sized part of the buffer into the log. No=
te
> + * that the buffer must have been allocated from the gfs2_log_buf_pool
> + * mempool and that after this has been called, ownership has been
> + * transferred and the buffer may be freed at any time.
>   */
>
> -static void gfs2_log_write_page(struct gfs2_sbd *sdp, struct page *page)
> +static void gfs2_log_write_block(struct gfs2_sbd *sdp, void *buf)
>  {
>         struct super_block *sb =3D sdp->sd_vfs;
>         u64 dblock;
>
>         dblock =3D gfs2_log_bmap(sdp->sd_jdesc, sdp->sd_log_flush_head);
>         gfs2_log_incr_head(sdp);
> -       gfs2_log_write(sdp, sdp->sd_jdesc, page, sb->s_blocksize, 0, dblo=
ck,
> -                      REQ_OP_WRITE);
> +       gfs2_log_write_buf(sdp, sdp->sd_jdesc, buf, sb->s_blocksize, dblo=
ck,
> +                          REQ_OP_WRITE);
>  }
>
>  /**
> @@ -604,12 +653,14 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct g=
fs2_log_header_host *head)
>         return ret;
>  }
>
> -static struct page *gfs2_get_log_desc(struct gfs2_sbd *sdp, u32 ld_type,
> -                                     u32 ld_length, u32 ld_data1)
> +static struct gfs2_log_descriptor *gfs2_get_log_desc(struct gfs2_sbd *sd=
p,
> +                                                    u32 ld_type, u32 ld_=
length,
> +                                                    u32 ld_data1)
>  {
> -       struct page *page =3D mempool_alloc(gfs2_page_pool, GFP_NOIO);
> -       struct gfs2_log_descriptor *ld =3D page_address(page);
> -       clear_page(ld);
> +       struct gfs2_log_descriptor *ld;
> +
> +       ld =3D mempool_alloc(gfs2_log_buf_pool, GFP_NOIO);
> +       memset(ld, 0, sdp->sd_sb.sb_bsize);
>         ld->ld_header.mh_magic =3D cpu_to_be32(GFS2_MAGIC);
>         ld->ld_header.mh_type =3D cpu_to_be32(GFS2_METATYPE_LD);
>         ld->ld_header.mh_format =3D cpu_to_be32(GFS2_FORMAT_LD);
> @@ -617,7 +668,7 @@ static struct page *gfs2_get_log_desc(struct gfs2_sbd=
 *sdp, u32 ld_type,
>         ld->ld_length =3D cpu_to_be32(ld_length);
>         ld->ld_data1 =3D cpu_to_be32(ld_data1);
>         ld->ld_data2 =3D 0;
> -       return page;
> +       return ld;
>  }
>
>  static void gfs2_check_magic(struct buffer_head *bh)
> @@ -652,7 +703,6 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, =
unsigned int limit,
>  {
>         struct gfs2_log_descriptor *ld;
>         struct gfs2_bufdata *bd1 =3D NULL, *bd2;
> -       struct page *page;
>         unsigned int num;
>         unsigned n;
>         __be64 *ptr;
> @@ -665,10 +715,9 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp,=
 unsigned int limit,
>                 if (total > limit)
>                         num =3D limit;
>                 spin_unlock(&sdp->sd_log_lock);
> -               page =3D gfs2_get_log_desc(sdp,
> -                                        is_databuf ? GFS2_LOG_DESC_JDATA=
 :
> -                                        GFS2_LOG_DESC_METADATA, num + 1,=
 num);
> -               ld =3D page_address(page);
> +               ld =3D gfs2_get_log_desc(sdp,
> +                                      is_databuf ? GFS2_LOG_DESC_JDATA :
> +                                      GFS2_LOG_DESC_METADATA, num + 1, n=
um);
>                 spin_lock(&sdp->sd_log_lock);
>                 ptr =3D (__be64 *)(ld + 1);
>
> @@ -684,7 +733,7 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, =
unsigned int limit,
>                 }
>
>                 spin_unlock(&sdp->sd_log_lock);
> -               gfs2_log_write_page(sdp, page);
> +               gfs2_log_write_block(sdp, ld);
>                 spin_lock(&sdp->sd_log_lock);
>
>                 n =3D 0;
> @@ -696,8 +745,7 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, =
unsigned int limit,
>                         if (buffer_escaped(bd2->bd_bh)) {
>                                 void *p;
>
> -                               page =3D mempool_alloc(gfs2_page_pool, GF=
P_NOIO);
> -                               p =3D page_address(page);
> +                               p =3D mempool_alloc(gfs2_log_buf_pool, GF=
P_NOIO);
>                                 memcpy_from_folio(p, bd2->bd_bh->b_folio,
>                                                   bh_offset(bd2->bd_bh),
>                                                   bd2->bd_bh->b_size);
> @@ -705,7 +753,7 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, =
unsigned int limit,
>                                 clear_buffer_escaped(bd2->bd_bh);
>                                 unlock_buffer(bd2->bd_bh);
>                                 brelse(bd2->bd_bh);
> -                               gfs2_log_write_page(sdp, page);
> +                               gfs2_log_write_block(sdp, p);
>                         } else {
>                                 gfs2_log_write_bh(sdp, bd2->bd_bh);
>                         }
> @@ -856,7 +904,7 @@ static void revoke_lo_before_commit(struct gfs2_sbd *=
sdp, struct gfs2_trans *tr)
>         struct gfs2_meta_header *mh;
>         unsigned int offset;
>         struct gfs2_bufdata *bd;
> -       struct page *page;
> +       void *buf;
>         unsigned int length;
>
>         gfs2_flush_revokes(sdp);
> @@ -864,29 +912,30 @@ static void revoke_lo_before_commit(struct gfs2_sbd=
 *sdp, struct gfs2_trans *tr)
>                 return;
>
>         length =3D gfs2_struct2blk(sdp, sdp->sd_log_num_revoke);
> -       page =3D gfs2_get_log_desc(sdp, GFS2_LOG_DESC_REVOKE, length, sdp=
->sd_log_num_revoke);
> +       buf =3D gfs2_get_log_desc(sdp, GFS2_LOG_DESC_REVOKE, length,
> +                               sdp->sd_log_num_revoke);
>         offset =3D sizeof(struct gfs2_log_descriptor);
>
>         list_for_each_entry(bd, &sdp->sd_log_revokes, bd_list) {
>                 sdp->sd_log_num_revoke--;
>
>                 if (offset + sizeof(u64) > sdp->sd_sb.sb_bsize) {
> -                       gfs2_log_write_page(sdp, page);
> -                       page =3D mempool_alloc(gfs2_page_pool, GFP_NOIO);
> -                       mh =3D page_address(page);
> -                       clear_page(mh);
> +                       gfs2_log_write_block(sdp, buf);
> +                       buf =3D mempool_alloc(gfs2_log_buf_pool, GFP_NOIO=
);
> +                       mh =3D buf;
> +                       memset(mh, 0, sdp->sd_sb.sb_bsize);
>                         mh->mh_magic =3D cpu_to_be32(GFS2_MAGIC);
>                         mh->mh_type =3D cpu_to_be32(GFS2_METATYPE_LB);
>                         mh->mh_format =3D cpu_to_be32(GFS2_FORMAT_LB);
>                         offset =3D sizeof(struct gfs2_meta_header);
>                 }
>
> -               *(__be64 *)(page_address(page) + offset) =3D cpu_to_be64(=
bd->bd_blkno);
> +               *(__be64 *)(buf + offset) =3D cpu_to_be64(bd->bd_blkno);
>                 offset +=3D sizeof(u64);
>         }
>         gfs2_assert_withdraw(sdp, !sdp->sd_log_num_revoke);
>
> -       gfs2_log_write_page(sdp, page);
> +       gfs2_log_write_block(sdp, buf);
>  }
>
>  void gfs2_drain_revokes(struct gfs2_sbd *sdp)
> diff --git a/fs/gfs2/lops.h b/fs/gfs2/lops.h
> index 772557b63b48..c1d9e6fef7ac 100644
> --- a/fs/gfs2/lops.h
> +++ b/fs/gfs2/lops.h
> @@ -14,9 +14,9 @@ extern const struct gfs2_log_operations *gfs2_log_ops[]=
;
>
>  void gfs2_log_incr_head(struct gfs2_sbd *sdp);
>  u64 gfs2_log_bmap(struct gfs2_jdesc *jd, unsigned int lbn);
> -void gfs2_log_write(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
> -                   struct page *page, unsigned size, unsigned offset,
> -                   u64 blkno, blk_opf_t opf);
> +void gfs2_log_write_buf(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
> +                       void *buf, unsigned int size, u64 blkno,
> +                       blk_opf_t opf);
>  void gfs2_log_submit_write(struct bio **biop);
>  void gfs2_pin(struct gfs2_sbd *sdp, struct buffer_head *bh);
>  int gfs2_find_jhead(struct gfs2_jdesc *jd,
> diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
> index a607e98eb45f..0da4cfbe54ea 100644
> --- a/fs/gfs2/main.c
> +++ b/fs/gfs2/main.c
> @@ -166,8 +166,8 @@ static int __init init_gfs2_fs(void)
>         if (!gfs2_freeze_wq)
>                 goto fail_wq3;
>
> -       gfs2_page_pool =3D mempool_create_page_pool(64, 0);
> -       if (!gfs2_page_pool)
> +       gfs2_log_buf_pool =3D mempool_create_kmalloc_pool(64, PAGE_SIZE);

We actually need s_blocksize size rather than PAGE_SIZE buffers here.
How about a per-sbd mempool instead of a global one?

> +       if (!gfs2_log_buf_pool)
>                 goto fail_mempool;
>
>         gfs2_register_debugfs();
> @@ -187,7 +187,7 @@ static int __init init_gfs2_fs(void)
>  fail_fs2:
>         unregister_filesystem(&gfs2_fs_type);
>  fail_fs1:
> -       mempool_destroy(gfs2_page_pool);
> +       mempool_destroy(gfs2_log_buf_pool);
>  fail_mempool:
>         destroy_workqueue(gfs2_freeze_wq);
>  fail_wq3:
> @@ -240,7 +240,7 @@ static void __exit exit_gfs2_fs(void)
>
>         rcu_barrier();
>
> -       mempool_destroy(gfs2_page_pool);
> +       mempool_destroy(gfs2_log_buf_pool);
>         kmem_cache_destroy(gfs2_trans_cachep);
>         kmem_cache_destroy(gfs2_qadata_cachep);
>         kmem_cache_destroy(gfs2_quotad_cachep);
> diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
> index 529c3ec37a18..1fd5f817312b 100644
> --- a/fs/gfs2/util.c
> +++ b/fs/gfs2/util.c
> @@ -34,7 +34,7 @@ struct kmem_cache *gfs2_rgrpd_cachep __read_mostly;
>  struct kmem_cache *gfs2_quotad_cachep __read_mostly;
>  struct kmem_cache *gfs2_qadata_cachep __read_mostly;
>  struct kmem_cache *gfs2_trans_cachep __read_mostly;
> -mempool_t *gfs2_page_pool __read_mostly;
> +mempool_t *gfs2_log_buf_pool __read_mostly;
>
>  void gfs2_assert_i(struct gfs2_sbd *sdp)
>  {
> diff --git a/fs/gfs2/util.h b/fs/gfs2/util.h
> index ffcc47d6b0b4..399c20004283 100644
> --- a/fs/gfs2/util.h
> +++ b/fs/gfs2/util.h
> @@ -165,7 +165,7 @@ extern struct kmem_cache *gfs2_rgrpd_cachep;
>  extern struct kmem_cache *gfs2_quotad_cachep;
>  extern struct kmem_cache *gfs2_qadata_cachep;
>  extern struct kmem_cache *gfs2_trans_cachep;
> -extern mempool_t *gfs2_page_pool;
> +extern mempool_t *gfs2_log_buf_pool;
>  extern struct workqueue_struct *gfs2_control_wq;
>
>  static inline unsigned int gfs2_tune_get_i(struct gfs2_tune *gt,
>
> --
> 2.39.5
>

Thanks,
Andreas

