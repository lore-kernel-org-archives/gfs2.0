Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6F15908A9
	for <gfs2@lists.linux.dev>; Tue,  8 Sep 2026 22:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907119; cv=none; b=Yz6sfXevvcQIxhqfDwqPjy7+7qBZNC71PamEoVVA1SmDx73eslIJQeXpEYFj30caA3SuxU5jgFfWPJfOi5BWQtVXGKleiCbdzc33NgtpHEwM1L0SuIe7WRaTLhgFgmtHmfrNJgG6vNPEmZ2va2xctfvO1PghJs1+Rzv0lkK/mMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907119; c=relaxed/simple;
	bh=FC044eHYM2+RBC12+m4Qgu1/XwdZOQnrZVu8TffsGpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EW51ZmigQ1sDt3gh5E9TFlxBigZYHKYq5/Q9njQd62oxV/XV3K8w3OV1ckwN6Y9ni1wayclqMGaB9+fXYbamic0X3y0GQOMT9Y4AQ9DQm9psI2pTo3IvtUxSkjor26ofLpP1ppqcTHNCpzBmuM5PEANGnQj3Ry5+x6tYkkFNSmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qjto6rUP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qjto6rUP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788907113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ji7zioczppTe+3MGsUl6/c0jkx8Em0m0PBXcaDYGVJM=;
	b=Qjto6rUPZ+vYA4XF8BQ3lIbYgM2hfm9rRzzxc0Rljk0N+Cf5BYVyKXc0NpvRacGpf3T9zv
	yy9YlrLBZNN3CbmXBS4nJ8qvt/kkraKDdKo6IPeGgZbZxHnv9B85EeD8UKz61D9KS/HDJb
	ItS2mcvy7p3SOtpX1TQ8Ie5w7vY2LrI=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-NQKX4vIJNZ6wnLGEpePFgA-1; Tue, 08 Sep 2026 18:38:32 -0400
X-MC-Unique: NQKX4vIJNZ6wnLGEpePFgA-1
X-Mimecast-MFC-AGG-ID: NQKX4vIJNZ6wnLGEpePFgA_1788907111
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-66d1d35738aso1905989d50.1
        for <gfs2@lists.linux.dev>; Tue, 08 Sep 2026 15:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788907111; x=1789511911;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ji7zioczppTe+3MGsUl6/c0jkx8Em0m0PBXcaDYGVJM=;
        b=V30rsCojwqpEDNkS3qRnJk8KrNSF8fRk0d0TRBkPGVOhW4dNoIzGxv+NKpVwEkyyp5
         OvDlNvSRHIR8GsHXqEx+kc8ogh6UmHG73hZ5mx85HU6iM6/j+caz0HoGc+SfNDhnwuFu
         QIiicA0JxCT7HDfZ5go8y2XzzEvIJRaVZxoD8XCXMvfzrPPnxfFomQuSvB972FOcFCql
         LlsiZJ0ltLwGhdb2XZBgaYSJCrI9wGD42/tqTsGs4nBR+kpMYtJO2E2K9G8x4qBm8zu8
         mwErNJdTYJf6AUBWOguUxS7tHhM16CalWc9pJuMvhgTotAyhu8Fnyau5ToGuV3DfhMRv
         D5HQ==
X-Gm-Message-State: AFuF++nB4JgCHUbyBh1C6G/H35EMtwJtg+F4WfZTqIdKZvUeKaFwFl1D
	XJxto23ZUSL6bM3+cnSxSfyF9JS3qDpnDAT2mTVk0M9nVrGjGgoBxa2Uo8SEaAKFsXf68n88LgH
	iL6QF/r1v8qFQjSJXsQ7NVf6BDwPqmXR8BaSwOUOKYERgHJ+3oT/XUH94vnPduh6fFhETR6J7ym
	jZM2JE68e57boZTUmmwRSw1KgUmbxC9A==
X-Gm-Gg: AYBFou11S7pY/9J8peQeyA20TEH3QwLtH7O3EwOmhEJDQG/mWlY0HzA9vtmMAUEQhSK
	b7OO6yKpEMp26iCoZy1X+nObraklVW+Czc8ctWsF4o9dQLGhK/IpSAdLDb2QZDeQRiejQbtbn7H
	I4U15/All+GYWOrg+6Gr6G4y1O5WXOSIQZMlLuom5B3CCSj4zk0e90Su20evJ/Qh5suIEpAQ4l3
	IGrzo9TaAmfDv+HEdxN/ufbFj0UltNH/IXHEl/06btF
X-Received: by 2002:a05:690e:144f:b0:66f:c1bc:4042 with SMTP id 956f58d0204a3-670f4a57464mr2702331d50.35.1788907111410;
        Tue, 08 Sep 2026 15:38:31 -0700 (PDT)
X-Received: by 2002:a05:690e:144f:b0:66f:c1bc:4042 with SMTP id
 956f58d0204a3-670f4a57464mr2702320d50.35.1788907110940; Tue, 08 Sep 2026
 15:38:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260906080821.24403-1-ngocthang2710.1999@gmail.com>
In-Reply-To: <20260906080821.24403-1-ngocthang2710.1999@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 9 Sep 2026 00:38:20 +0200
X-Gm-Features: AcwNN1V6U7-Oh-HSWs6kQWHmSLFyXz8cRWxpAuKbiRb6GtSDGrLDP-4NaQ7bA54
Message-ID: <CAHc6FU6nzAQb9wGF8KfA1LuRH+eqVabNkZ3f3gc+_2rxasoRnw@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix NULL deref in gfs2_quota_lock() for meta inodes
To: ThangNN99 <ngocthang2710.1999@gmail.com>
Cc: gfs2@lists.linux.dev, 
	syzbot+d84e35a320d14f8c270a@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8y3PVS0AJ4XrSmw3vYODWFcLW5YsbMkcpbXsen_94XQ_1788907111
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 10:08=E2=80=AFAM ThangNN99 <ngocthang2710.1999@gmail=
.com> wrote:
> gfs2_quota_hold() now treats a meta/system inode's NULL i_qadata as
> success, but gfs2_quota_lock() still dereferences it unconditionally
> afterwards. Bail out early when there is nothing to lock.
>
> Reported-by: syzbot+d84e35a320d14f8c270a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd84e35a320d14f8c270a
> Fixes: 0025112796287599dc79c822ed37124582a0d68a ("gfs2: No quotas for met=
a inodes")
> Signed-off-by: ThangNN99 <ngocthang2710.1999@gmail.com>
> ---
>  fs/gfs2/quota.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 3bbe5c78c793..0c7ea7375f6c 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -1100,6 +1100,9 @@ int gfs2_quota_lock(struct gfs2_inode *ip, kuid_t u=
id, kgid_t gid)
>         error =3D gfs2_quota_hold(ip, uid, gid);
>         if (error)
>                 return error;
> +       /* Meta inodes never get quota data (see gfs2_qa_get()); nothing =
to lock. */
> +       if (!ip->i_qadata)
> +               return 0;
>
>         sort(ip->i_qadata->qa_qd, ip->i_qadata->qa_qd_num,
>              sizeof(struct gfs2_quota_data *), sort_qd, NULL);
> --
> 2.43.0
>

Applied, thanks.

Andreas

