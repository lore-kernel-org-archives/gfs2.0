Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAF6331A6E
	for <gfs2@lists.linux.dev>; Fri, 24 Jul 2026 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907195; cv=none; b=pAuXLyAwjtg6Hqw3oK2N0ZmsmWQN6hCRB47+Sd+Qjn7gsQTRoh+8jaUbIk0Z0BgxgYYkFQp2HJOnkOKNlDrJe+kHw0R/ZLS8pz+eqSeDX5T3UJSy3DCdzWsOfXtgCZ6F7e1xkUP1fKb9ex9Vo1T2JSpe3XT6KjYvRPzFLQ0lG8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907195; c=relaxed/simple;
	bh=uePHYOfboWCk3Dzy0goe5iolQs0BM73iSufJQUlGG98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5PrjyEFmZNn+jOwfhHyL/Jblnr4qw+GsmGZf5rkx3acAMQjgHZaqHBCnJWIx5cuB2jDTOA27f3Ptpqbhc2YGYGwzpXfezyDcu2h6PT8RIODnaC/Jep2/j3e3ec5sHVQCfWDC4POYdV2eYAuKu1y3nFb5ZwMd0qmu+K/05dxNkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c2OcFphn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2OcFphn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784907192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0wYLo5A978tG9+nVwb6dAJHz/jrs4O6PNzjqHsmL6A=;
	b=c2OcFphnlZmnqAc0J4i79DRGIAaoZJgOMnJUD4dCmi3fum9se2MMFubWJwbjQjI8q7KgXD
	YqMd4S+AyypqD8evIbq/F0VMAw6yxqOHzOYgWyN9uRz51wpLdgCYFqU6jQRQb3CSiqSQpK
	1o6+oENi3lA1AlKu/QbbwOcU70E5EJQ=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-qDtqFo6AM4yXZel7I4WmrA-1; Fri, 24 Jul 2026 11:33:11 -0400
X-MC-Unique: qDtqFo6AM4yXZel7I4WmrA-1
X-Mimecast-MFC-AGG-ID: qDtqFo6AM4yXZel7I4WmrA_1784907191
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81e6abfca68so5014687b3.1
        for <gfs2@lists.linux.dev>; Fri, 24 Jul 2026 08:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784907190; x=1785511990;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b0wYLo5A978tG9+nVwb6dAJHz/jrs4O6PNzjqHsmL6A=;
        b=A2A9GWhgLUkpsPKLm/ZGV3hT8f457ez4f6wywYbAlQ6cB1TW1HuOa7F3BLAKIpRUQP
         aHbJ2eR7Ib0z4AWV6G3GOlhWYIg+5YF2ONQ0yrgJLEmK5lzRsC634J2lF6EBCRuepFwu
         zrIq7p+uMs4iJYrqIYzI5pEEGgG3K1/5WByfZ6B3VmHY6KEv/sn3+e6Y9puW9JjzXkYM
         VeZWwtyF4IVEx32CY5RMKCqaw5cr++UeWAfsvJnQN5AGMQHxzP/Pjpp3dUC0A5HtwIf3
         xCeXSeYwbQfDEp7sysHomcurDStWXLkqOXFFk+5SI3kgapCbdtM/qOJL6c0v7plgK0Jf
         qEWA==
X-Gm-Message-State: AOJu0YwMRp7YP9bMedyggZUhKxCnADJSqTPpT+dWKYuoiA9Ff88BvbpY
	5Ntk/OyICoYDHmv+y13F7HCWbSpQFkHbpDTEYWQkp6qLc1A5x57Nz4SY9R4+vKwltvoGDlyHNUd
	8re6BXXifREOwMPY03cj1tOLV1Jf4vBtEjphJ8Co1sQl2ORL2UJiV6mFUN2R8q0ZUj8tXmV39k8
	z11dgGtJs0qB3QcHPw4+kgO/Hy/Pn2pw==
X-Gm-Gg: AR+sD12p7wJb+vbadVecfy/WJ93Id1hUSeqw9W12qyeGuLh6vt72RB3W8kgMAeBu2M1
	Xh/Jdhu39GRcoKplKBQobzZbyXOm1jGItqLGnY2QMq58unXEtbUfvv84jL1cR7JogHS73iQhVT+
	AutpdgcPlAqd7JzcCMqzXqdCmY4Ks/3wTEpoKlQ98vdEOnmXm9AO/YQ3jUXc8lSj+Pv88IEdjjT
	KrfwjeHUb4otHlHcU0Rc/Ntg6jzi49Pm8adekmKUc/o
X-Received: by 2002:a05:690c:7202:b0:81e:8a49:1ff8 with SMTP id 00721157ae682-81f4c31368cmr25813897b3.45.1784907190578;
        Fri, 24 Jul 2026 08:33:10 -0700 (PDT)
X-Received: by 2002:a05:690c:7202:b0:81e:8a49:1ff8 with SMTP id
 00721157ae682-81f4c31368cmr25813797b3.45.1784907190022; Fri, 24 Jul 2026
 08:33:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <6a439474.4d70c427.9c655.9b2d@mx.google.com>
In-Reply-To: <6a439474.4d70c427.9c655.9b2d@mx.google.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 24 Jul 2026 17:32:58 +0200
X-Gm-Features: AUfX_mw66X4_yNuRkOSj8SIjIy0HdSQBGjziWcULobdcO5PFyK6WOUCmR5rz0J8
Message-ID: <CAHc6FU606F2o-YD7_J7k8b_uUUzGOJyu_3vvkO1NN2c5_-q+8Q@mail.gmail.com>
Subject: Re: [PATCH] gfs2: add missing __rcu annotation to i_gl in incore.h
To: Adrian Garcia Casado <adriangarciacasado42@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T_Kt5xR7et9Gk_19VuPD4MWRuWXgWGoY-UOXAN8TGfQ_1784907191
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 12:03=E2=80=AFPM Adrian Garcia Casado
<adriangarciacasado42@gmail.com> wrote:
> In gfs2_inode_lookup() and other parts of the GFS2 filesystem,
> ip->i_gl is accessed and dereferenced via RCU helpers like
> rcu_dereference_check() and rcu_access_pointer(). However, the
> actual i_gl pointer in struct gfs2_inode was never annotated
> with __rcu in incore.h.
>
> This missing annotation causes Sparse to throw multiple
> "incompatible types in comparison expression (different address spaces)"
> warnings and compilation-blocking errors under strict static analysis bui=
lds.

Indeed, there are two sparse errors related to i_gl.

> Fix this by adding the __rcu annotation to i_gl in struct gfs2_inode.

With this fix, I get about 200 sparse warnings instead of the two
errors. So thanks for pointing out that there are errors, but without
fixing any of the underlying problems, this patch isn't very useful.

Andreas

> Signed-off-by: Adrian Garcia Casado <adriangarciacasado42@gmail.com>
> Tested-by: Adrian Garcia Casado <adriangarciacasado42@gmail.com>
> ---
>
> diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
> index 6146577..16df753 100644
> --- a/fs/gfs2/incore.h
> +++ b/fs/gfs2/incore.h
> @@ -392,7 +392,7 @@ struct gfs2_inode {
>         u64 i_generation;
>         u64 i_eattr;
>         unsigned long i_flags;          /* GIF_... */
> -       struct gfs2_glock *i_gl;
> +       struct gfs2_glock __rcu *i_gl;
>         struct gfs2_holder i_iopen_gh;
>         struct gfs2_qadata *i_qadata; /* quota allocation data */
>         struct gfs2_holder i_rgd_gh;

Applied, thanks.



Andreas

