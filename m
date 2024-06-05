Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70720DF43
	for <gfs2@lists.linux.dev>; Wed,  5 Jun 2024 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717613696; cv=none; b=uYanvij+bOWy6+fJrmT/18Y/o+2GjgXK+gCZqAWZNss6LOcCBuTuhDsa8kVTEa91n54B34uocjUsl3b1RZLFO9zoeEnRFwCiHt8GTBki2sAPHZlK6seu+2wv0xrGifbEWOp4ImJpx8cVRQ10zRceocW6tJFt8axM0iWA/kVABuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717613696; c=relaxed/simple;
	bh=k3Z3DKv75s5pFe9+ENmCP9Q8nErOA3BvZKtPYSmiVCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwaGwFM80gf34MQ+KMhRQymRDqUhP/KGonhD0xs57WSCDBvc1K01RLjJReAWgOOs7Zcz8atcGsL00oAAHCEb7FzCztHeqFbPQtEXeSTPxsxderE6EFiTvWVTGDk76Yh7EbFvegnp+QK8GsA6ihDqDrYG7Qv2v6ig3s191AEnDtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hofYYx5v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hofYYx5v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717613693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3Z3DKv75s5pFe9+ENmCP9Q8nErOA3BvZKtPYSmiVCQ=;
	b=hofYYx5vMZZoDRt+W6FBsWTZrM+rfjoloYsYigWPrWZz+WQBfptK2IObIKNhnZoAn7dQWm
	HNcN8a3KbiRY5XRZS5Zp1/lXp+qIO/Q6poO2tfzNUIinpqbMv3EFSbfVeIfYK3Z4nrJtCa
	xT6ttb7Agb4d4YacnfvWYkDeojv+/qs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-Pc3p8V-tODiHj_r3w_H0GQ-1; Wed, 05 Jun 2024 14:54:52 -0400
X-MC-Unique: Pc3p8V-tODiHj_r3w_H0GQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2eaa0215594so945821fa.1
        for <gfs2@lists.linux.dev>; Wed, 05 Jun 2024 11:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717613690; x=1718218490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3Z3DKv75s5pFe9+ENmCP9Q8nErOA3BvZKtPYSmiVCQ=;
        b=rt9kS1kBypeAA+Zl1/uormHPDqopovPm81lb1yyZ8hJ594KPulgx0gOQ4/lvUgAhs2
         MTs/Xch6FVGrdk/zO1cQLqjpqjRkXPo5wUlQh8q/Is38mPk26bAj6n+wDt4EpxvtYJeK
         1OYCvGJdwAe048C5uQ2EBzdVMkw4c8oYuLl+Ti30kOSbm7McCWvTl083iR10t+2lUWod
         cWLNdpPAfLwo1M12w2d6pCg4sjZukrPWSqoNLFNU0FhAFRNh3PkkJ0zESBBpOkCkx0gp
         DIG4xKNE9ON3nhjbWwf4YImQVA0bBFFgBIgshOi5iTvZTMaaFOSIwJfls5tQof+awf/A
         NgGg==
X-Gm-Message-State: AOJu0Yz8ZWtboP6Zycnr8pPZoTrQ+6qQMhmpVKcWAmjL8cpgYwEWBnE3
	1zDKAolvxFynucbUMFgJAmRr+BkQTATGvzGc12fQjDWFeO4EJ3aKj0MCU7gsP05r05foB1CAj53
	CD9ZkcmoWBIYjWtqWj+a/OXnSav1KkpVyuT4MsISyOhm1BswXm/T6UHraW3gtakcMRe6sAknyX3
	a44e7rC+bqcrx8A4W17Z/Q0HmxfZnwzlal/HIP
X-Received: by 2002:a2e:b682:0:b0:2e6:ccfd:fae1 with SMTP id 38308e7fff4ca-2eac79bfd47mr19319791fa.17.1717613690512;
        Wed, 05 Jun 2024 11:54:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRtAer/gXo+tP1WyS7r5yx6ZXydl1feHR9wjzM39UEmsAgVtJGcDexqkLOSh0vBcQ043XV5KcYE70gD/wSqLs=
X-Received: by 2002:a2e:b682:0:b0:2e6:ccfd:fae1 with SMTP id
 38308e7fff4ca-2eac79bfd47mr19319701fa.17.1717613690120; Wed, 05 Jun 2024
 11:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240603215558.2722969-1-aahringo@redhat.com> <20240603215558.2722969-9-aahringo@redhat.com>
In-Reply-To: <20240603215558.2722969-9-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 5 Jun 2024 14:54:38 -0400
Message-ID: <CAK-6q+i18_oHfdh6Odfidi0y4hWiR9bn_svWf2BwPqnLwdEFGQ@mail.gmail.com>
Subject: Re: [PATCH dlm/next 8/8] md-cluster: use DLM_LSFL_SOFTIRQ for dlm_new_lockspace()
To: teigland@redhat.com, heming.zhao@suse.com, yukuai3@huawei.com, 
	song@kernel.org
Cc: gfs2@lists.linux.dev, linux-raid@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 3, 2024 at 5:56=E2=80=AFPM Alexander Aring <aahringo@redhat.com=
> wrote:
>
> Recently the DLM subsystem introduced the flag DLM_LSFL_SOFTIRQ for
> dlm_new_lockspace() to signal the capability to handle DLM ast/bast
> callbacks in softirq context to avoid an additional context switch due
> the DLM callback workqueue.
>
> The md-cluster implementation only does synchronized calls above the
> async DLM API. That synchronized API should may be also offered by DLM,
> however it is very simple as md-cluster callbacks only does a complete()
> call for their wait_for_completion() wait that is occurred after the
> async DLM API call. This patch activates the recently introduced
> DLM_LSFL_SOFTIRQ flag that allows that the DLM callbacks are executed in
> a softirq context that md-cluster can handle. It is reducing a
> unnecessary context workqueue switch and should speed up DLM in some
> circumstance.
>

Can somebody with a md-cluster environment test it as well? All I was
doing was (with a working dlm_controld cluster env):

mdadm --create /dev/md0 --bitmap=3Dclustered --metadata=3D1.2
--raid-devices=3D2 --level=3Dmirror /dev/sda /dev/sdb

sda and sdb are shared block devices on each node.

Create a /etc/mdadm.conf with the content mostly out of:

mdadm --detail --scan

on each node.

Then call mdadm --assemble on all nodes where not "mdadm --create ..." happ=
ened.
I hope that is the right thing to do and I had with "dlm_tool ls" a
UUID as a lockspace name with some md-cluster locks being around.

To bring this new flag upstream, would it be okay to get this through
dlm-tree? I am requesting here for an "Acked-by" tag from the md
maintainers.

Thanks.

- Alex

