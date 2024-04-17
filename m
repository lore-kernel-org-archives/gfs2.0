Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FFC13C8EA
	for <gfs2@lists.linux.dev>; Wed, 17 Apr 2024 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354050; cv=none; b=QPjb0kP84237voE5xUnEpYhE039k+JXXDLYSSoHEHJ6EiuJks8NbT7+pu7Ozsz/UyIZFeZDd6vJgS2+dYU2JKf6FyXlxtNzzNc9dejxrL5rji5Gk5z/FXgix7TWVvnd06dhvS/1TwZha4qbn65czsDIUQt/V2zPZeWHSkqK+epc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354050; c=relaxed/simple;
	bh=UleH45v2JxgonZhsx9G653Pl6fJWAC7ykZs1aPCoGvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhvZayfXUl/iFj459VVN0axcTzrihs7wCe6sYSoccENe++dUKlZ8uvA1vmCOoHJiPAk05dB+e8fQhhYC1H5Eo3H8LIz7xTjZNamWt4PEPrY6RZFRlo12BHKsuzmXTPPsOvDyuhmB2JF5FQk1QmaV/sSfWSoNR+1KkQ/WhB851xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=glwU3DOd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glwU3DOd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713354047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeebRnX/BWwg5OwgWqih4TdoNfl8RwZ74w+fGyak3GA=;
	b=glwU3DOdStrCrUg/QN++7PV1iin+B3j5B/BfR9DdrY2jcLdfZSzugs9mtCULTtmQXvEX8U
	z5vN7Qv8bcIyg9Xrj/lH0O0OIOIfri2LZBkJoD18Kis59PHjIyGB8WLym4Man1CnmwXT/1
	Fsjloz+oLXPx7UCqt3gD5/qRRzRxpnk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-MK5__8gmNsKyYH0FaI0fzw-1; Wed, 17 Apr 2024 07:40:45 -0400
X-MC-Unique: MK5__8gmNsKyYH0FaI0fzw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d99533a6c3so3711341fa.0
        for <gfs2@lists.linux.dev>; Wed, 17 Apr 2024 04:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713354044; x=1713958844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeebRnX/BWwg5OwgWqih4TdoNfl8RwZ74w+fGyak3GA=;
        b=fhEmn/+h4nhIx5FLnTcKTqj1R3issXRMt/PEh/VvKcXY+Njpk2MQQTuYYg1FJ23KP9
         5UVr+L93WGmD3NtI4aFl4paGeCpElyGw5VISwDYqzjysOaAlid13aDnB7cLqrPz6LnlW
         JS7Yvnqjq0cjbTEZ+t0PdYMjSNIF2LgcUD2qm+X7BezQ6CLpg5xSKzhP2jGOdXVHa0Hf
         vy4XNiGRdC4wYAxoJcIJjyVVwoLlOwwTSJnJfjiHV1QG4UUpD8cRGzUPm7RTrPU3lSLy
         t8syHNrhQId46A5GyHO+qFFjdMjUGyz0tKKv9TgeSl3qJKLKc6NKSR5RVWZtKxtHNi03
         3BQg==
X-Gm-Message-State: AOJu0YzUwsYyvsXvkRsAOrTB2shKp4YXU1C6P+F+W4XHsa15Xxf7adsy
	wAPOqeT60I5XptVGJnreko6rHuVgfQDgQseVO09pa0DOQFonjMs+grZUtLOzyQuMZhSZ6+m2MFT
	NAx09dPQsmhZuymYeT3hbHkLc7FiB3B2OLTwBGiuAYHTELneER1N0u32rFWEkku7VqX7iFOBoHs
	q/NG5lg+CAcvFGfV7x4+QtML9BoQ==
X-Received: by 2002:a2e:9f4c:0:b0:2d8:4637:405f with SMTP id v12-20020a2e9f4c000000b002d84637405fmr1829257ljk.9.1713354044425;
        Wed, 17 Apr 2024 04:40:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXFF+iLdsQSleOArQ9NN/F7yoyZsbnSqTpsMvbpE4Z5b3BBRp0TomD38+Ogn5nyXR/GQEVG+aScybbCivj2qY=
X-Received: by 2002:a2e:9f4c:0:b0:2d8:4637:405f with SMTP id
 v12-20020a2e9f4c000000b002d84637405fmr1829245ljk.9.1713354044046; Wed, 17 Apr
 2024 04:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240415183943.645497-1-aahringo@redhat.com> <20240415183943.645497-8-aahringo@redhat.com>
In-Reply-To: <20240415183943.645497-8-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 17 Apr 2024 07:40:32 -0400
Message-ID: <CAK-6q+gnZs+jCi=nezCT4fZ85__N55R05Bq5G5cuzA=kcutqzQ@mail.gmail.com>
Subject: Re: [PATCHv2 dlm/next 7/9] dlm: drop scand kthread and use timers
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 15, 2024 at 2:39=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> Currently the scand kthread acts like a garbage collection for expired
> rsbs on toss list to clean them up after a certain timeout. It triggers
> every couple of seconds and iterates over the toss list while holding
> ls_rsbtbl_lock for the whole hash bucket iteration. To reduce the amount
> of holding the ls_rsbtbl_lock time we handle free of cached rsbs (tossed
> rsbs) on a per rsb timer. If it expires the rsb deletes itself out of
> the rsb toss queue that is an ordered queue of tossed rsbs. First entry
> is the earliest rsb to expire the last is the lastest rsb that will expir=
e.
> The res_toss_time is now an absolute value of when it will be expired
> before it was the time when the rsb was tossed. It was an debug
> functionality for debugfs anyway, we change a little bit the semantic
> here.
>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/dlm/dlm_internal.h |  16 +-
>  fs/dlm/lock.c         | 382 ++++++++++++++++++++++++++----------------
>  fs/dlm/lock.h         |   2 +
>  fs/dlm/lockspace.c    | 105 ++----------
>  fs/dlm/member.c       |   2 +
>  fs/dlm/recover.c      |   5 +
>  fs/dlm/recoverd.c     |  10 ++
>  7 files changed, 283 insertions(+), 239 deletions(-)
>
> diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
> index cf43b97cf3e5..98a0ac511bc8 100644
> --- a/fs/dlm/dlm_internal.h
> +++ b/fs/dlm/dlm_internal.h
> @@ -334,6 +334,7 @@ struct dlm_rsb {
>         struct list_head        res_root_list;      /* used for recovery =
*/
>         struct list_head        res_masters_list;   /* used for recovery =
*/
>         struct list_head        res_recover_list;   /* used for recovery =
*/
> +       struct list_head        res_toss_q_list;
>         int                     res_recover_locks_count;
>
>         char                    *res_lvbptr;
> @@ -584,13 +585,20 @@ struct dlm_ls {
>         spinlock_t              ls_lkbidr_spin;
>
>         struct rhashtable       ls_rsbtbl;
> -#define DLM_RTF_SHRINK_BIT     0
> -       unsigned long           ls_rsbtbl_flags;
>         spinlock_t              ls_rsbtbl_lock;
>
>         struct list_head        ls_toss;
>         struct list_head        ls_keep;
>
> +       struct timer_list       ls_timer;
> +       /* this queue is ordered according the
> +        * absolute res_toss_time jiffies time
> +        * to mod_timer() with the first element
> +        * if necessary.
> +        */
> +       struct list_head        ls_toss_q;
> +       spinlock_t              ls_toss_q_lock;
> +
>         spinlock_t              ls_waiters_lock;
>         struct list_head        ls_waiters;     /* lkbs needing a reply *=
/
>
> @@ -601,9 +609,6 @@ struct dlm_ls {
>         int                     ls_new_rsb_count;
>         struct list_head        ls_new_rsb;     /* new rsb structs */
>
> -       char
...
> +       spin_unlock_bh(&ls->ls_rsbtbl_lock);
> +
>         goto out_unlock;
>
>
> @@ -777,6 +1009,9 @@ static int find_rsb_nodir(struct dlm_ls *ls, const v=
oid *name, int len,
>          * valid for keep state rsbs
>          */
>         kref_init(&r->res_ref);
> +       rsb_delete_toss_timer(ls, r);
> +       spin_unlock_bh(&ls->ls_rsbtbl_lock);
> +
>         goto out_unlock;

those spin_unlock_bh() are twice there... just for note I realized it
now, it was fixed in the next patch. Probably because I was doing some
git rebase things and tried to solve conflicts and made this
mistake...

- Alex

